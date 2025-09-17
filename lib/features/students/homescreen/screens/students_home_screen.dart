import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Model/students_model.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/students/assignment/screens/assignment_home_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/attendence/screens/attendence_home_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/homescreen/widgets/feature_card.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/resource_home_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/test/screens/main_screen.dart';
import 'package:badges/badges.dart' as badges;
import '../../../../utills/local_storage.dart';
import '../../announcement/screens/all_announcements_screen.dart';
import '../../announcement/services/announcement_service.dart';
import '../../fee/screens/fee_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  final Students student;

  const StudentHomeScreen({super.key, required this.student});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {


  final service = AnnouncementService();
  int badgeCount = 0;

  @override
  void initState() {
    super.initState();
    // This is for checking app update
    _listenToAnnouncements();
  }

  void _listenToAnnouncements() async {
    final lastSeen = await LocalStorage.getLastSeen();

    service.getAnnouncements().listen((announcements) {
      final total = announcements.length;
      setState(() {
        badgeCount = total - lastSeen;
        if (badgeCount < 0) badgeCount = 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 4 / 4,
            children: [
              GestureDetector(
                child: FeatureCard(icon: Icons.assignment, title: "Test"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => StudentFeeDashboard(
                            userId: widget.student.userId,
                          ),
                    ),
                  );
                },
                child: FeatureCard(icon: Icons.attach_money, title: "Fees"),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => StudentAttendanceDashboard(
                            student: widget.student,
                          ),
                    ),
                  );
                },
                child: FeatureCard(
                  icon: Icons.check_circle,
                  title: "Attendance",
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AssignmentHomeScreen(),
                    ),
                  );
                },
                child: FeatureCard(
                  icon: Icons.assignment_turned_in,
                  title: "Assignment",
                ),
              ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClassSelectionScreen(),
                    ),
                  );
                },
                child: FeatureCard(icon: Icons.folder, title: "Resource"),
              ),
              GestureDetector(
                onTap: () async {
                  // Jab student announcements screen kholta hai -> lastSeen update
                  final totalAnnouncements =
                      await service.getAnnouncements().first;
                  await LocalStorage.setLastSeen(totalAnnouncements.length);
                  // Badge reset

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllAnnouncementsScreen(),
                    ),
                  );
                  Future.delayed(Duration(milliseconds: 100),() {
                    setState(() {
                      badgeCount = 0;
                      _listenToAnnouncements();
                    });
                  },);

                },
                child: badges.Badge(
                  showBadge: badgeCount > 0,
                  badgeAnimation: badges.BadgeAnimation.slide(), // smooth slide effect
                  position: badges.BadgePosition.topEnd(top: 0, end: 12), // better alignment
                  stackFit: StackFit.passthrough,
                  badgeStyle: badges.BadgeStyle(
                    shape: badges.BadgeShape.circle,
                    badgeColor: Colors.redAccent, // stylish color
                    padding: const EdgeInsets.all(10), // compact padding
                    elevation: 4, // little shadow for depth
                    borderSide: const BorderSide(color: Colors.white, width: 1.5), // white border for clarity
                  ),
                  badgeContent: Text(
                    badgeCount.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28, // smaller text for balance
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: FeatureCard(
                    icon: Icons.campaign,
                    title: "Announcements",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
