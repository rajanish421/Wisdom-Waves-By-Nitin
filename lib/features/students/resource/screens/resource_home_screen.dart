import 'package:flutter/material.dart';
import '../services/file_services.dart';
import 'subject_screen.dart';


class ClassSelectionScreen extends StatelessWidget {
  final FileService fileService = FileService();

  // Exact India Flag Colors
  final Color saffron = const Color(0xFFFF9933);
  final Color white = Colors.white;
  final Color green = const Color(0xFF138808);
  final Color chakraBlue = const Color(0xFF000080);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose your Class"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<String>>(
        future: fileService.getClasses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final classes = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 cards per row
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.2,
              ),
              itemCount: classes.length,
              itemBuilder: (context, index) {
                final className = classes[index];

                // Row-wise color logic (to mimic flag)
                Color bgColor;
                Color iconColor;
                Color textColor;

                if (index < 4) {
                  // Top rows (1–4) -> Saffron
                  bgColor = saffron;
                  iconColor = Colors.white;
                  textColor = Colors.white;
                } else if (index < 8) {
                  // Middle rows (5–8) -> White + Chakra Blue
                  bgColor = white;
                  iconColor = chakraBlue;
                  textColor = chakraBlue;
                } else {
                  // Bottom rows (9–12) -> Green
                  bgColor = green;
                  iconColor = Colors.white;
                  textColor = Colors.white;
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SubjectScreen(className: className),
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
                            getIconForClass(className),
                            size: 50,
                            color: iconColor,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            getClassLabel(className),
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

  /// ✅ Proper class label with suffix
  String getClassLabel(String number) {
    switch (number) {
      case "1":
        return "Class 1st";
      case "2":
        return "Class 2nd";
      case "3":
        return "Class 3rd";
      default:
        return "Class ${number}th";
    }
  }

  /// ✅ Icons per class (customize as you like)
  IconData getIconForClass(String number) {
    switch (number) {
      case "1":
        return Icons.looks_one;
      case "2":
        return Icons.looks_two;
      case "3":
        return Icons.looks_3;
      case "4":
        return Icons.looks_4;
      case "5":
        return Icons.looks_5;
      case "6":
        return Icons.looks_6;
      case "7":
        return Icons.science;
      case "8":
        return Icons.public;
      case "9":
        return Icons.square_foot;
      case "10":
        return Icons.assignment;
      case "11":
        return Icons.bubble_chart;
      case "12":
        return Icons.school;
      default:
        return Icons.class_;
    }
  }
}
