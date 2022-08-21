import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snakebabu/button.dart';
import 'package:snakebabu/direction.dart';

class ScreenControl extends StatelessWidget {

  final void Function(Direction direction) onTapped;
  const ScreenControl({Key? key,required this.onTapped}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 50.0,
      child: Row(
      children: [
        Expanded(child: Row(
          children: [
            Expanded(child: Container(),
           ),
            Button(onPressed: (){
              onTapped(Direction.left);
            },icon: Icon(Icons.arrow_left,color: Colors.black,),)
          ],
        )),
        Expanded(child: Column(
          children: [
            Button(onPressed: (){
              onTapped(Direction.up);
            },icon: Icon(Icons.arrow_drop_up,color: Colors.black,),
            ),
            SizedBox(
              height: 70,
            ),
            Button(onPressed: (){
              onTapped(Direction.down);
            },icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
            ),
          ],
        )),
         Expanded(child: Row(
          children: [
            Button(onPressed: (){
              onTapped(Direction.right);
            },icon: Icon(Icons.arrow_right,color: Colors.black,),
            ), Expanded(child: Container(),
           ),
          ],
        ))
      ],
    ));
  }
}