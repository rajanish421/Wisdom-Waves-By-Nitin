import 'package:flutter/material.dart';

class ResourceHomeScreen extends StatelessWidget {
  const ResourceHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resources"),
      ),
      body: Center(child: Text("No Resource"),),
    );
  }
}
