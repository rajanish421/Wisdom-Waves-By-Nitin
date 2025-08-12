import 'package:flutter/material.dart';


void showCustomSnackBar({required String text , required BuildContext context}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)),);
}