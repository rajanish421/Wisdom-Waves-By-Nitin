import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:animations/animations.dart';

class StudentAttendanceDashboard extends StatefulWidget {
  // final String batchId;
  final String studentId;

  const StudentAttendanceDashboard({
    Key? key,
    // required this.batchId,
    required this.studentId,
  }) : super(key: key);

  @override
  State<StudentAttendanceDashboard> createState() =>
      _StudentAttendanceDashboardState();
}

class _StudentAttendanceDashboardState
    extends State<StudentAttendanceDashboard> {
  int totalDays = 0;
  int presentDays = 0;
  String batchId = "jliH1926aaS6bXPbxwMi";

  /// Fetch attendance percentage
  Future<void> calculateAttendance() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("attendance")
        .doc(batchId)
        .collection("dates")
        .get();

    int present = 0;
    int total = snapshot.docs.length;
    // print(total);

    for (var doc in snapshot.docs) {
      final data = doc.data();
      print("-------------------------------------->>>>>>>>>>>>>>>>>>");
      final List students = data["students"] ?? [];

      final student = students.firstWhere(
            (s) => s["userId"] == widget.studentId,
        orElse: () => null,
      );
      if (student != null && student["status"] == true) {
        present++;
      }
    }

    setState(() {
      totalDays = total;
      presentDays = present;
    });
  }

  @override
  void initState() {
    super.initState();
    calculateAttendance();
  }

  @override
  Widget build(BuildContext context) {
    double percentage =
    totalDays == 0 ? 0 : (presentDays / totalDays).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Attendance",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          // Animated Percentage Circle
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: CircularPercentIndicator(
                radius: 80.0,
                lineWidth: 15.0,
                animation: true,
                animationDuration: 1000,
                percent: percentage,
                center: Text(
                  "${(percentage * 100).toStringAsFixed(1)}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                progressColor: percentage >= 0.75
                    ? Colors.green
                    : (percentage >= 0.5 ? Colors.orange : Colors.red),
                backgroundColor: Colors.grey.shade300,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Attendance History",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Animated List of past attendance
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("attendance")
                  .doc(batchId)
                  .collection("dates")
                  .orderBy(FieldPath.documentId, descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                // if(snapshot.connectionState == ConnectionState.waiting){
                //   return CircularProgressIndicator();
                // }
                if (!snapshot.hasData) {
                  return const Center(child: Text("no data"));
                }

                final docs = snapshot.data!.docs;
                print(docs.length);

                if (docs.isEmpty) {
                  return const Center(child: Text("No attendance history yet"));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    final date = docs[index].id;
                    final List students = data["students"] ?? [];
                    // print(students);
                    final student = students.firstWhere(
                          (s) => s["userId"] == widget.studentId,
                      orElse: () => null,
                    );
                    print(student);
                    final status =
                    student != null ? student["status"] : false;
                    print(status);
                    return  Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text("Date: $date"),
                        subtitle: Text("Status: $status"),
                        trailing: Icon(
                          status == true
                              ? Icons.check_circle
                              : Icons.cancel,
                          color: status == true
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
