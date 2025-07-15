import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:wisdom_waves_by_nitin/home_screen.dart';
import 'dart:async';

import 'onBoarding/onBoarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;
  double _position = 100;

  @override
  void initState() {
    super.initState();

    // Trigger animation
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
        _position = 0;
      });
    });

    // Navigate after 3.5 seconds
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 1000),
        opacity: _opacity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 🔰 Logo
            Image.asset('assets/images/logo1.png', height: 300),

            const SizedBox(height: 10),

            // 🔤 App Name with Slide Animation
            AnimatedPadding(
              duration: const Duration(milliseconds: 1000),
              padding: EdgeInsets.only(top: _position),
              child: Column(
                children: [
                  Text(
                    'Wisdom Waves by Nitin',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  // const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
                height: 200,
                child: LoadingIndicator(indicatorType: Indicator.ballClipRotateMultiple,colors: [Colors.white],strokeWidth:5,)
               ),
            Text(
              'Learn.Grow.Excel',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.85),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
