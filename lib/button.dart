import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final  Function onPressed;
  final Icon icon;
  const Button({Key? key,required this.onPressed,required this.icon}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Opacity(opacity: 0.5,
    child: Container(
      width: 80.0,
      height: 80.0,
      child: FittedBox(
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 0.0,
            onPressed: (){
              onPressed();
            },
            child: icon
          ),
        ),
      ),
    ),);
  }
}