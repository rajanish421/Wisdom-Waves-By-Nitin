import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/features/students/discussion/screens/discussion_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/homescreen/screens/students_home_screen.dart';

import '../../constant/app_colors.dart';
import '../comman/screens/about_us_screen.dart';
class StudentsBottomNavBar extends StatefulWidget {
  const StudentsBottomNavBar({super.key});

  @override
  State<StudentsBottomNavBar> createState() => _StudentsBottomNavBarState();
}

class _StudentsBottomNavBarState extends State<StudentsBottomNavBar> {
  int _page = 1;
  int _index = 1;


  List<Widget> pages = [
    DiscussionScreen(),
    StudentHomeScreen(),
    AboutUsScreen(),
  ];

  void onTapped(int index) {
    setState(() {
      _page = index;
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi, Rajanish Singh"),
        // centerTitle: true,
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu,size: 32,)),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications,size: 32,),)
        ],
      ),
      body: pages[_page],
      bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: AppColors.backgroundColor,
          buttonBackgroundColor: AppColors.appBarColor,
          color: AppColors.appBarColor,
          animationDuration: Duration(milliseconds: 200),
          onTap: onTapped,
          index: _index,
          items: [
            Icon(Icons.contact_page,color: Colors.white,size: 30,),
            Icon(Icons.home,color: Colors.white,size: 30,),
            Icon(Icons.person_3_outlined,color: Colors.white,size: 30,)
          ]),
    );
  }
}
