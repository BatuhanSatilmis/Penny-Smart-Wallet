import 'package:flutter/material.dart';
import 'package:penny_smart_wallet/views/view_login/login_view.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double containerSize = 400.0;
  Color containerColor = Colors.black;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      setState(() {
        containerSize = 100.0;
        containerColor = Colors.transparent;
      });

      Timer(Duration(milliseconds: 500), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginPageView(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedContainer(
          duration: Duration(seconds: 2),
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            color: containerColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset('images/splash_v1.png'),
        ),
      ),
    );
  }
}
