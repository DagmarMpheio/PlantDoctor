import 'package:apptest/color/app_color.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/homeScreen');
      }
      ;
    });
  }

  @override
  void initState() {
    super.initState();
    // Iniciar o cronômetro
    startTimer();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 168, 102, 2),
            Color.fromARGB(255, 24, 146, 28)
          ], begin: Alignment.topRight, end: Alignment.bottomLeft),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 250,
              width: MediaQuery.of(context).size.width - 100,
            ),
            Text(
              "PlantDoctor",
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: "CandyJelly",
                  color: AppColor.black),
            ),
          ],
        ),
      ),

    );
  }
}
