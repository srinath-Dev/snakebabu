import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:snakebabu/game.dart';
import 'package:snakebabu/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
       debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: EasySplashScreen(
      logo: Image.asset('images/logos.png'),
      logoWidth: 220.0,
    
      backgroundColor: Color.fromARGB(255, 107, 85, 166),
      showLoader: true,
      loaderColor: Colors.white,
      navigator: GamePage(),
      durationInSeconds: 5,
    )
    
    );
  }
}

