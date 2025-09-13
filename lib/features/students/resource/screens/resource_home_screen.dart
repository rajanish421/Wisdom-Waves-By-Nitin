import 'package:flutter/material.dart';
import '../services/file_services.dart';
import 'subject_screen.dart';

class ClassSelectionScreen extends StatelessWidget {
  final FileService fileService = FileService();

  final List<Map<String, dynamic>> classIcons = [
    {"icon": Icons.extension, "color": Colors.blue},       // Class 6
    {"icon": Icons.science, "color": Colors.green},        // Class 7
    {"icon": Icons.public, "color": Colors.orange},        // Class 8
    {"icon": Icons.square_foot, "color": Colors.purple},   // Class 9
    {"icon": Icons.assignment, "color": Colors.red},       // Class 10
    {"icon": Icons.bubble_chart, "color": Colors.teal},    // Class 11
    {"icon": Icons.school, "color": Colors.indigo},        // Class 12
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Choose your Class"),centerTitle: true,),
      body: FutureBuilder<List<String>>(
        future: fileService.getClasses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final classes = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,        // 2 cards per row
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final className = classes[index];
                final icon = classIcons[index]['icon'];
                final color = classIcons[index]['color'];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectScreen(className: className),));
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
                          Text("class ${className}th", style: TextStyle(
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
          );
        },
      ),
    );
  }
}


