import 'package:flutter/material.dart';
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subTitle;
  FeatureCard({super.key, required this.icon,required this.title,required this.subTitle});


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      color: Colors.red,
      margin: EdgeInsets.all(5),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}
