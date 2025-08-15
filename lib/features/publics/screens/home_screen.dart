import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Custom_Widget/button.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/publics/widgets/courses_card.dart';
import 'package:wisdom_waves_by_nitin/features/students/auth/services/auth_services.dart';
import 'package:wisdom_waves_by_nitin/features/students/fee/services/fee_services.dart';
import 'package:wisdom_waves_by_nitin/features/students/students_bottom_nav_bar.dart';

import '../../../Model/students_model.dart';
import '../../students/auth/screens/login_screen.dart';
import '../widgets/announcement_cart.dart';
import '../widgets/topper_carousel.dart';
import 'feature_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});


  final List<Map<String, String>> announcements = [
    {
      'title': 'Weekly Test Announcement',
      'description': 'The next weekly test for all classes will be held on Saturday at 10:00 AM. Please be prepared.'
    },
    {
      'title': 'Holiday Notice',
      'description': 'The institute will remain closed on 15th August due to Independence Day celebrations.'
    },
    {
      'title': 'Extra Classes Scheduled',
      'description': 'Extra classes for Class 10 Science and Math will be held on Friday evening from 4 PM to 6 PM.'
    },
    {
      'title': 'Result Declaration',
      'description': 'Unit Test results will be declared on Monday. You can collect your mark sheets from the office.'
    },
    {
      'title': 'Parent-Teacher Meeting',
      'description': 'PTM is scheduled for Sunday, 10:00 AM to 1:00 PM. Parents are requested to attend without fail.'
    },
    {
      'title': 'New Course Launch: Class 11 & 12',
      'description': 'We are excited to announce new batches for Class 11 & 12 (Science Stream) starting next month.'
    },
    {
      'title': 'Fee Submission Reminder',
      'description': 'Kindly submit the tuition fee for the current month before the 10th to avoid late charges.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                "Welcome To Wisdom Waves By Nitin Bhaiya",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontFamily: 'Lobster'),
              ),
              SizedBox(height: 10),
              CustomButton(
                text: "Login as a Student -> ",
                onPressed: () async
                {
                  bool isLoggedIn = FirebaseAuth.instance.currentUser != null;
                  if(isLoggedIn){
                    String uid = FirebaseAuth.instance.currentUser!.uid;
                    final student = await FirebaseFirestore.instance.collection("students").where('uid',isEqualTo: uid).limit(1).get();
                     Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsBottomNavBar(student: Students.fromMap(student.docs.first.data()),),));
                  }else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                  }
                },
                fontSize: 22,
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FeatureScreen(),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackgroundColor,
                    border: Border.all(color: Colors.grey, width: 3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.widgets, size: 80, color: Colors.blue),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Why Wisdom Waves",
                              style: TextStyle(
                                fontSize: 25,
                                fontFamily: 'Titan',
                                color: Colors.blue,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "Tap to see all features",
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Our Toppers",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              TopperCarousel(),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    "Our Courses",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  GestureDetector(
                      onTap: (){

                      },
                      child: Text("See all",style: TextStyle(color: Colors.red),)),
                ],
              ),
              CoursesCard(),
              SizedBox(height: 10),
              SizedBox(height: 10),
              Text(
                "Up Coming Courses",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              CoursesCard(upComing: true,),
              Text(
                "Announcements",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height:200,child: ListView(
                scrollDirection: Axis.horizontal,
                children: announcements.map((e) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AnnouncementCart(subTitle: e['description'] as String, title: e['title'] as String),
                  );
                },).toList(),
              )),

            ],
          ),
        ),
      ),
    );
  }
}
