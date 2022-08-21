import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:snakebabu/direction.dart';
import 'package:snakebabu/piece.dart';
import 'package:snakebabu/screen_control.dart';

class GamePage extends StatefulWidget {
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late int upperBoundX, upperBoundY, lowerBoundX, lowerBoundY;
  late double screenWidth, screenHeight;
  int step = 30;
  late Piece food;
  Offset? foodPosition;
  int length = 5;
  Direction direction = Direction.right;
  List<Offset> positions = [];
  Timer? timer;
  int score = 0;
  double speed = 1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    restart();
  }

  Direction getRandomDirection(){

    int val = Random().nextInt(4);
    direction = Direction.values[val];
    return direction;
  }

  void restart() {
    length =5;
    score = 0;
    speed=1;
    positions = [];
    direction = getRandomDirection();
    changeSpeed();
  }

  void changeSpeed() {
    if (timer != null && timer!.isActive) {
      timer!.cancel();
    }
    timer = Timer.periodic(Duration(milliseconds: 200 ~/ speed), (timer) {
      setState(() {});
    });
  }

  Widget getControls() {
    return ScreenControl(onTapped: (Direction newDirection) {
      direction = newDirection;
    });
  }

  int getNearestTens(int num) {
    int output;
    output = (num ~/ step) * step;
    if (output == 0) {
      output += step;
    }
    return output;
  }

  void draw() async{
    if (positions.length == 0) {
      positions.add(getRandomPosition());
    }

    while (length > positions.length) {
      positions.add(positions[positions.length - 1]);
    }

    for (var i = positions.length - 1; i > 0; i--) {
      positions[i] = positions[i - 1];
    }

    positions[0] = await getNextPosition(positions[0]);
  }

  bool detectCollision(Offset position) {
    if (position.dx >= upperBoundX && direction == Direction.right) {
      return true;
    } else if (position.dx <= lowerBoundX && direction == Direction.left) {
      return true;
    } else if (position.dy >= upperBoundY && direction == Direction.down) {
      return true;
    } else if (position.dy <= lowerBoundY && direction == Direction.up) {
      return true;
    }
    return false;
  }

  Future<Offset> getNextPosition(Offset position) async {
    late Offset nextPosition;

    if (direction == Direction.right) {
      nextPosition = Offset(position.dx + step, position.dy);
    } else if (direction == Direction.left) {
      nextPosition = Offset(position.dx - step, position.dy);
    } else if (direction == Direction.up) {
      nextPosition = Offset(position.dx, position.dy - step);
    } else if (direction == Direction.down) {
      nextPosition = Offset(position.dx, position.dy + step);
    }

    if (detectCollision(position) == true) {

      if(timer != null &&timer!.isActive){
        timer!.cancel();
      }

      await Future.delayed(Duration(milliseconds: 200), () => {
       showGameOverDialog()
      });
      return position;
    }

    return nextPosition;
  }

  Offset getRandomPosition() {
    Offset position;

    int posX = Random().nextInt(upperBoundX) + lowerBoundX;
    int posY = Random().nextInt(upperBoundY) + lowerBoundY;

    position = Offset(
        getNearestTens(posX).toDouble(), getNearestTens(posY).toDouble());
    return position;
  }

  void showGameOverDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 107, 85, 166),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.red, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            title: Text(
              "wow nice game....",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "en porumaiya romba sothikkara, ithu dhaan unoda score" +" "+
                 "'"+ score.toString() +"'",
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop();
                    restart();
                  },
                  child: Text(
                    "Restart Game",
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.red,
                        fontWeight: FontWeight.w500),
                  ))
            ],
          );
        });
  }

  void drawFood() {
    if (foodPosition == null) {
      foodPosition = getRandomPosition();
    }

    if (foodPosition == positions[0]) {
      length++;
      score = score + 5;
      speed = speed + 0.25;
      foodPosition = getRandomPosition();
    }
    food = Piece(
      color: Colors.red,
      size: step,
      posX: foodPosition!.dx.toInt(),
      posY: foodPosition!.dy.toInt(),
      isAnimated: true,
    );
  }

  List<Piece> getPieces() {
    final pieces = <Piece>[];
    draw();
    drawFood();
    for (var i = 0; i < length; ++i) {
      if (i >= positions.length) {
        continue;
      }
      pieces.add(Piece(
        color: i.isEven ? Colors.red : Colors.yellow,
        size: step,
        posX: positions[i].dx.toInt(),
        posY: positions[i].dy.toInt(),
        isAnimated: false,
      ));
    }
    return pieces;
  }

  Widget getScore() {
    return Positioned(
        top: 80.0,
        right: 50.0,
        child: Text(
          "Score :" + score.toString(),
          style: TextStyle(fontSize: 20, color: Colors.white),
        ));
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    lowerBoundY = step;
    lowerBoundX = step;
    upperBoundY = getNearestTens(screenHeight.toInt() - step);
    upperBoundX = getNearestTens(screenWidth.toInt() - step);

    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 107, 85, 166),
        child: Stack(
          children: [
            Stack(
              children: getPieces(),
            ),
            getControls(),
            food,
            getScore(),
          ],
        ),
      ),
    );
  }
}
