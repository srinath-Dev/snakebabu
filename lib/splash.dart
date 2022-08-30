import 'dart:async';

import 'package:flutter/material.dart';
import 'package:snakebabu/game.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({Key? key}) : super(key: key);

  static const String id = 'splash screen';


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      homeStatus();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 107, 85, 166),
      body: Center(
          child: Hero(
        tag: 'Splash_logo',
        child: Image.asset('images/logo.png'),
      )),
    );
  }
  homeStatus() async {
    
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => GamePage()), (Route<dynamic> route) => false);
    
  }


}