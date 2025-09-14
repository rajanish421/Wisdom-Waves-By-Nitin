import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static void show({
    required String message,
    ToastGravity gravity = ToastGravity.BOTTOM,
    Color backgroundColor = const Color(0xFF333333),
    Color textColor = Colors.white,
    double fontSize = 16.0,
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: 2,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
