import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ new import
import 'package:wisdom_waves_by_nitin/Model/students_model.dart';
import 'package:wisdom_waves_by_nitin/comman/widgets/profile.dart';
import 'package:wisdom_waves_by_nitin/features/students/discussion/screens/discussion_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/homescreen/screens/students_home_screen.dart';

import '../../constant/app_colors.dart';
import '../../utills/local_storage.dart';
import '../comman/screens/about_us_screen.dart';
import 'announcement/screens/all_announcements_screen.dart';
import 'announcement/services/announcement_service.dart';
import 'discussion/services/discussion_repository.dart';

class StudentsBottomNavBar extends StatefulWidget {
  final Students student;
  const StudentsBottomNavBar({super.key, required this.student});

  @override
  State<StudentsBottomNavBar> createState() => _StudentsBottomNavBarState();
}

class _StudentsBottomNavBarState extends State<StudentsBottomNavBar> {
  int _page = 1;
  int _index = 1;
  late final List<Widget> pages;

  DateTime? lastOpenedAt; // 🔹 track when student last opened discussion
  bool hasUnread = false; // 🔹 track unread state

  final _discussionRepo = DiscussionRepository();

  @override
  void initState() {
    super.initState();
    // _listenToAnnouncements();
    _loadLastOpenedAt(); // ✅ load from local storage

    pages = [
      DiscussionScreen(student: widget.student),
      StudentHomeScreen(student: widget.student),
      AboutUsScreen(),
    ];

    // 🔔 Listen for latest message
    _discussionRepo.latestMessageStream().listen((latest) {
      if (latest != null &&
          (lastOpenedAt == null || latest.isAfter(lastOpenedAt!))) {
        setState(() {
          hasUnread = true; // new message received
        });
      }
    });
  }

  /// ✅ Load saved timestamp
  Future<void> _loadLastOpenedAt() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMillis = prefs.getInt("lastOpenedAt");
    if (savedMillis != null) {
      setState(() {
        lastOpenedAt = DateTime.fromMillisecondsSinceEpoch(savedMillis);
      });
    }
  }

  /// ✅ Save timestamp when chat opened
  Future<void> _saveLastOpenedAt() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("lastOpenedAt", DateTime.now().millisecondsSinceEpoch);
  }

  void onTapped(int index) {
    setState(() {
      _page = index;
      _index = index;

      if (index == 0) {
        // 👀 User opened chat
        hasUnread = false;
        lastOpenedAt = DateTime.now();
        _saveLastOpenedAt(); // ✅ save to local storage
      }
    });
  }
  // for bell notification

  // final service = AnnouncementService();
  // int badgeCount = 0;
  //
  // void _listenToAnnouncements() async {
  //   final lastSeen = await LocalStorage.getLastSeen();
  //
  //   service.getAnnouncements().listen((announcements) {
  //     final total = announcements.length;
  //     setState(() {
  //       badgeCount = total - lastSeen;
  //       if (badgeCount < 0) badgeCount = 0;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final student = widget.student;

    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, ${student.name}"),
        centerTitle: true,
        actions: [
          Stack(
            children:[
              IconButton(
              onPressed: () async{
                // final totalAnnouncements =
                //     await service.getAnnouncements().first;
                // await LocalStorage.setLastSeen(totalAnnouncements.length);
                //
                // // Badge reset
                //
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => AllAnnouncementsScreen(),
                //   ),
                // );
                // setState(() {
                //   badgeCount = 0;
                // });
              },
              icon: const Icon(Icons.notifications, size: 32),
            ),
              // Positioned(
              //   right: 12,
              //   top: 10,
              //   child: Container(
              //     width: 15,
              //     height: 15,
              //     decoration: const BoxDecoration(
              //       color: Colors.red,
              //       shape: BoxShape.circle,
              //     ),
              //   ),
              // ),
            ]
          ),
        ],
      ),
      drawer: ProfileScreen(student: student),
      body: pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: AppColors.backgroundColor,
        buttonBackgroundColor: AppColors.appBarColor,
        color: AppColors.appBarColor,
        animationDuration: const Duration(milliseconds: 200),
        onTap: onTapped,
        index: _index,
        items: [
          Stack(
            children: [
              const Icon(Icons.contact_page, color: Colors.white, size: 30),
              if (hasUnread && _index != 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
          const Icon(Icons.home, color: Colors.white, size: 30),
          const Icon(Icons.person_3_outlined, color: Colors.white, size: 30),
        ],
      ),
    );
  }
}
