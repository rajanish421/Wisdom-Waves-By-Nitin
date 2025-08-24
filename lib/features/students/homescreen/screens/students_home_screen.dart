import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Model/students_model.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/students/announcement/screens/announcement_home_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/assignment/screens/assignment_home_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/attendence/screens/attendence_home_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/download/screens/download_home_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/homescreen/widgets/feature_card.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/resource_home_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/test/screens/main_screen.dart';

import '../../fee/screens/fee_screen.dart';

class StudentHomeScreen extends StatelessWidget {
  final Students student;
  const StudentHomeScreen({super.key,required this.student});

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
    print(student);
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
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen(),));
                    },
                  ),
                  GestureDetector(
                    onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => FeeScreen(student: student,),));
                    },
                    child: FeatureCard(icon: Icons.attach_money, title: "Fees"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AttendanceHomeScreen(),));
                    },
                    child: FeatureCard(
                      icon: Icons.check_circle,
                      title: "Attendance",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AssignmentHomeScreen(),));

                    },
                    child: FeatureCard(
                      icon: Icons.assignment_turned_in,
                      title: "Assignment",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DownloadHomeScreen(),));

                    },
                    child: FeatureCard(
                      icon: Icons.download,
                      title: "Downloads",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceHomeScreen(),));

                    },
                    child: FeatureCard(icon: Icons.folder, title: "Resource"),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AnnouncementHomeScreen(),));

                    },
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
