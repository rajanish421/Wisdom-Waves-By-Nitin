import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/resource_screen.dart';
import '../services/file_services.dart';

class SubjectScreen extends StatelessWidget {
  final String className;
  final FileService fileService = FileService();

  SubjectScreen({required this.className});

  final Color saffron = const Color(0xFFFF9933);
  final Color white = Colors.white;
  final Color green = const Color(0xFF138808);
  final Color chakraBlue = const Color(0xFF000080);

  // Custom icons for subjects
  final List<IconData> subjectsIcon = [
    Icons.biotech,        // Biology
    Icons.local_drink,    // Chemistry
    Icons.public,         // GK
    Icons.calculate,      // Math
    Icons.bolt,           // Physics
    Icons.map,            // SST
    Icons.science,        // Science
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class - $className"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<String>>(
        future: fileService.getSubjects(className),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final subjects = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: subjects.length,
              itemBuilder: (context, index) {
                final subjectName = subjects[index];

                // Assign flag-style colors for 7 subjects
                Color bgColor;
                Color iconColor = Colors.white;
                Color textColor = Colors.white;

                if (index < 2) {
                  bgColor = saffron; // Top 2 → Saffron
                } else if (index < 6) {
                  bgColor = white;   // Middle 3 → White
                  iconColor = chakraBlue;
                  textColor = chakraBlue;
                } else {
                  bgColor = green;   // Bottom 2 → Green
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResourceScreen(
                          className: className,
                          subjectName: subjectName,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: bgColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: GridTile(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            subjectsIcon[index],
                            size: 50,
                            color: iconColor,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            subjectName,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
