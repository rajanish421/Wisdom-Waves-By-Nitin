import 'package:flutter/material.dart';

class AssignmentHomeScreen extends StatelessWidget {
  const AssignmentHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignments"),
      ),
      body: Center(child: Text("No Assignments"),),
    );
  }
}
