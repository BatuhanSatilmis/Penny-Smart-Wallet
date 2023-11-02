import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:penny_smart_wallet/app/routes/app_router.dart';
import 'dart:async';

@RoutePage()
class SplashScreenView extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenView> {
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
        context.router.replace(LoginPageViewRoute());
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
