import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/comman/widgets/bottom_nav_bar.dart';
import 'package:wisdom_waves_by_nitin/constant/app_theme.dart';
import 'package:wisdom_waves_by_nitin/features/publics/screens/home_screen.dart';
import 'package:wisdom_waves_by_nitin/splace_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wisdom Waves by Nitin',
      theme:AppThemes.lightTheme,
      // home: BottomNavBar(),
      home: SplashScreen(),
    );
  }
}