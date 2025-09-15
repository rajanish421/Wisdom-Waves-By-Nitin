import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import '../../features/comman/screens/about_us_screen.dart';
import '../../features/publics/screens/contact_screen.dart';
import '../../features/publics/screens/home_screen.dart';
import '../../update_checker.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 1;
  int _index = 1;


  List<Widget> pages = [
    ContactScreen(),
    HomeScreen(),
    AboutUsScreen(),
  ];

  void onTapped(int index) {
    setState(() {
      _page = index;
      _index = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UpdateChecker.checkLatestVersion(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart class - Learn Better!"),
        centerTitle: true,
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
