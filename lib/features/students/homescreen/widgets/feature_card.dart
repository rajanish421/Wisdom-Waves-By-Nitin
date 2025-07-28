
import 'package:flutter/material.dart';
class FeatureCard extends StatelessWidget {
  IconData icon;
  String title;
  FeatureCard({super.key,required this.icon,required this.title});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text("Opening ${feature['title']}")),
        // );
      },
      child: Container(
        decoration: _featureCardDecoration(),
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF1976D2),
              size: 100,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Inter"
              ),
            )
          ],
        ),
      ),
    );
  }
}


BoxDecoration _featureCardDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: const Offset(2, 4),
      )
    ],
  );
}
