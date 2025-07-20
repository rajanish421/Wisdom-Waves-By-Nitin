import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/features/publics/widgets/feature_card.dart';
class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Features"),
      ),
      body: ListView(
        children: [
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
          FeatureCard(icon: Icons.event_note,title: "Weekly Test",subTitle:"Evaluate your self",),
        ],
      ),
    );
  }
}
