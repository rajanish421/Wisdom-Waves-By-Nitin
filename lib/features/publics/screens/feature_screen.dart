import 'package:flutter/material.dart';

class FeatureScreen extends StatelessWidget {
  const FeatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        "icon": Icons.school,
        "title": "Dedicated Teachers",
        "subtitle": "Young, dynamic, and committed to your success",
      },
      {
        "icon": Icons.assignment_turned_in,
        "title": "Weekly Test",
        "subtitle": "Test weekly, track progress",
      },
      {
        "icon": Icons.question_answer,
        "title": "Discussion Classes",
        "subtitle": "Clear doubts through discussions",
      },
      {
        "icon": Icons.event_repeat,
        "title": "Weekly Extra Classes",
        "subtitle": "Extra help for tough topics",
      },
      {
        "icon": Icons.record_voice_over,
        "title": "Communication Skills",
        "subtitle": "Boost speaking and confidence",
      },
      {
        "icon": Icons.phone_iphone,
        "title": "Application Support",
        "subtitle": "Learn anytime with our app",
      },
      {
        "icon": Icons.description,
        "title": "DPP (Daily Practice)",
        "subtitle": "Practice daily, master concepts",
      },
      {
        "icon": Icons.star_rate,
        "title": "Special Classes",
        "subtitle": "Master high-weightage chapters",
      },
    ];


    return Scaffold(
      appBar: AppBar(
        title: const Text("Features"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: features.length,
              itemBuilder: (context, index) {
                final feature = features[index];
                return Card(
                  elevation: 2,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    minTileHeight: 100,
                    leading: SizedBox(
                      width: 60,
                      height: 80,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(feature["icon"] as IconData, color: Colors.blue,size: 50,),
                      ),
                    ),
                    title: Text(
                      feature["title"] as String,
                      style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                    ),
                    subtitle: Text(feature["subtitle"] as String,style: TextStyle(),),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
