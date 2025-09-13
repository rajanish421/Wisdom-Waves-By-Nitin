import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/resource_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/video_view_screen.dart';

import '../services/file_services.dart';


class SubjectScreen extends StatelessWidget {
  final String className;
  final FileService fileService = FileService();

  SubjectScreen({required this.className});

  final List<Map<String, dynamic>> subjectsIcon = [
    {"icon": Icons.biotech, "color": Colors.teal},       // Biology
    {"icon": Icons.local_drink, "color": Colors.red},      // Chemistry
    {"icon": Icons.public, "color": Colors.orange},      // GK
    {"icon": Icons.calculate, "color": Colors.blue},     // Math
    {"icon": Icons.bolt, "color": Colors.green},      // Physics
    {"icon": Icons.map, "color": Colors.purple},         // SST
    {"icon": Icons.science, "color": Colors.deepPurple},     // Science
    {"icon": Icons.bookmark, "color": Colors.brown},     // Future subject 1
    {"icon": Icons.auto_stories, "color": Colors.cyan},  // Future subject 2
    {"icon": Icons.menu_book_outlined, "color": Colors.indigo}, // Future subject 3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Class - ${className}th"),centerTitle: true,),
      body: FutureBuilder<List<String>>(
        future: fileService.getSubjects(className),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final subjects = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,        // 2 cards per row
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                // final subject = subjects[index];
                final subjectName = subjects[index];
                final icon = subjectsIcon[index]['icon'];
                final color = subjectsIcon[index]['color'];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceScreen(className: className,subjectName: subjectName,),));
                  },
                  child: Card(
                    color: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: GridTile(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon,size: 50, color: Colors.white),
                          SizedBox(height: 12),
                          Text(subjectName, style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),),
                        ],
                      ),

                    ),
                  ),
                );
              },
            ),
          );;
        },
      ),
    );
  }
}
