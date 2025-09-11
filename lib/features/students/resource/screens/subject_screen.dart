import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/resource_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/video_view_screen.dart';

import '../services/file_services.dart';


class SubjectScreen extends StatelessWidget {
  final String className;
  final FileService fileService = FileService();

  SubjectScreen({required this.className});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Subjects - $className")),
      body: FutureBuilder<List<String>>(
        future: fileService.getSubjects(className),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final subjects = snapshot.data!;
          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              return Card(
                child: ListTile(
                  title: Text(subjects[index]),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResourceScreen(className: className,subjectName: subject,)
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
