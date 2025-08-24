import 'package:flutter/material.dart';

class AttendanceHomeScreen extends StatelessWidget {
  const AttendanceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance"),
      ),
      body: Center(child: Text("No Attendance"),),
    );
  }
}
