
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Piece extends StatefulWidget {

  final bool isAnimated;
  final int posX, posY, size;
  final Color color;
  const Piece({Key? key, required this.color,required this.size,required this.posX,required this.posY, this.isAnimated = false}):super(key: key);
  @override
  State<Piece> createState() => _PieceState();
}

class _PieceState extends State<Piece> with SingleTickerProviderStateMixin {
 AnimationController? _animationController;

@override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      lowerBound: 0.25,
      upperBound: 1.0,
      duration: Duration(milliseconds: 1000),
      vsync: this);

      _animationController!.addStatusListener((status) {
        if(status==AnimationStatus.completed){
          _animationController!.reset();
        }else if(status==AnimationStatus.dismissed){
          _animationController!.forward();
        }
      });
      _animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.posY.toDouble(),
      left: widget.posX.toDouble(),
      child: Opacity(
        opacity: widget.isAnimated?_animationController!.value:1,
        child: Container(
          width: widget.size.toDouble(),
          height: widget.size.toDouble(),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(width: 2.0,color: Colors.white),
          ),
        ),
    ));
  }
}