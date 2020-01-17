

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:garuda_cabin_mobile/database/database_helper.dart';
import 'package:garuda_cabin_mobile/models/user.dart';
import 'package:garuda_cabin_mobile/screens/home_screen.dart';
import 'package:garuda_cabin_mobile/screens/login_screen.dart';

class SplashScreen extends StatefulWidget{

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  AnimationController _animationController;


  @override
  void initState(){

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    startSplashScreen();
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose(){
    _animationController.dispose();
    super.dispose();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    var db = new DatabaseHelper();
    User user = await db.getUser();
    String path = user == null ? "/login" : "/home";
    return Timer(duration, (){
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(
              settings: RouteSettings(name: '$path'),
              builder: (context) => user == null ? new LoginScreen() : new HomeScreen(user: user,)
          )
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child:  Image.asset(
          "assets/images/garuda_indonesia_3x.png",
          width: 200.0,
          height: 100.0,
        ),
//        child: RotationTransition(
//          turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
//          child:  Image.asset(
//            "assets/images/garuda_indonesia_3x.png",
//            width: 200.0,
//            height: 100.0,
//          ),
//        ),

      ),
    );
  }
}