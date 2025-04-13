import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vazouaqui/pages/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 175),
          child: Column(
            children: [
              Image.asset(
                "assets/images/splash_screen.png",
                height: 231,
                width: 224,
              ),
              Container(
                margin: const EdgeInsets.only(top: 55),
                child: const Text(
                  "VazôAqui",
                  style: TextStyle(
                      fontSize: 48,
                      color: Color.fromRGBO(0, 85, 126, 100)),
                ),
              )
            ],
          ),
        ));
  }
}
