import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/students/homescreen/widgets/feature_card.dart';

class StudentHomeScreen extends StatelessWidget {
  const StudentHomeScreen({super.key});

  /// Feature items list
  List<Map<String, dynamic>> get _featureItems => [
    {'title': 'Tests', 'icon': Icons.assignment},
    {'title': 'Fees', 'icon': Icons.attach_money},
    {'title': 'Attendance', 'icon': Icons.check_circle},
    {'title': 'Timetable', 'icon': Icons.calendar_month},
    {'title': 'Assignments', 'icon': Icons.assignment_turned_in},
    {'title': 'Downloads', 'icon': Icons.download},
    {'title': 'Resources', 'icon': Icons.folder},
    {'title': 'Announcements', 'icon': Icons.campaign},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0).copyWith(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 4 / 4,
                children: [
                  GestureDetector(
                    child: FeatureCard(icon: Icons.assignment, title: "Test"),
                    onTap: () {},
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: FeatureCard(icon: Icons.attach_money, title: "Fees"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: FeatureCard(
                      icon: Icons.check_circle,
                      title: "Attendance",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: FeatureCard(
                      icon: Icons.assignment_turned_in,
                      title: "Assignment",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: FeatureCard(
                      icon: Icons.download,
                      title: "Downloads",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: FeatureCard(icon: Icons.folder, title: "Resource"),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: FeatureCard(
                      icon: Icons.campaign,
                      title: "Announcements",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
