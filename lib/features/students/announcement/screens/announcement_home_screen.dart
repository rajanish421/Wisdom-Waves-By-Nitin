import 'package:flutter/material.dart';
 class AnnouncementHomeScreen extends StatelessWidget {
   const AnnouncementHomeScreen({super.key});
 
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Announcements"),
       ),
       body: Center(
         child: Text("No Announcement"),
       ),
     );
   }
 }
 