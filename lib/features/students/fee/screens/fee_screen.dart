import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:wisdom_waves_by_nitin/Model/fee_model.dart';

import '../../homescreen/services/fee_services.dart';

class StudentFeeDashboard extends StatelessWidget {
  final String userId;
  final StudentFeeService _feeService = StudentFeeService();

  StudentFeeDashboard({super.key, required this.userId});

  Map<int, String> monthList = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("My Fees"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.deepPurple,
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _feeService.getStudentFee(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(child: Text("No fee record found."));
          }

          final feeData = snapshot.data!.data()!;
          final totalFee = feeData['totalFee'] ?? 0;
          final paid = feeData['paid'] ?? 0;
          final pending = totalFee - paid;

          final double percent =
              totalFee > 0 ? (paid / totalFee).clamp(0.0, 1.0) : 0.0;

          // status logic
          String status;
          Color statusColor;
          if (pending == 0) {
            status = "Cleared";
            statusColor = Colors.green;
          } else if (paid == 0) {
            status = "Due";
            statusColor = Colors.red;
          } else {
            status = "Partial";
            statusColor = Colors.orange;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // _buildStudentHeader(feeData),
                // const SizedBox(height: 20),
                _buildFeeDashboard(
                  totalFee,
                  paid,
                  pending,
                  percent,
                  status,
                  statusColor,
                ),
                Expanded(
                  child: StreamBuilder(
                    stream:
                        FirebaseFirestore.instance
                            .collection("fee")
                            .doc(userId)
                            .collection("months")
                            .where("status", isEqualTo: "paid")
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData && snapshot.data!.docs.isEmpty) {
                        Text("No history");
                      }
                      final snapData = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: snapData.length,
                        itemBuilder: (context, index) {
                          final data = FeeMonth.fromMap(snapData[index].data());
                          String monthName =
                              "${monthList[data.month]} - ${monthList[data.year]}"
                                  .toString();
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Text(monthName),
                              trailing: Icon(Icons.check_circle,color: Colors.green,),
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
        },
      ),
    );
  }

  /// 🟣 Student Info Card
  Widget _buildStudentHeader(Map<String, dynamic> feeData) {
    return Card(
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.deepPurple,
              child: Text(
                (feeData['studentName'] ?? "S")[0],
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feeData['studentName'] ?? 'Student',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Roll No: ${feeData['rollNo'] ?? 'N/A'}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Class: ${feeData['class'] ?? 'N/A'}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "Session: ${feeData['session'] ?? 'N/A'}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 🟣 Fee Dashboard Card
  Widget _buildFeeDashboard(
    int total,
    int paid,
    int pending,
    double percent,
    String status,
    Color statusColor,
  ) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              "Fee Overview",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Circular Chart
            CircularPercentIndicator(
              radius: 80,
              lineWidth: 22,
              percent: percent,
              center: Text(
                "${(percent * 100).toStringAsFixed(0)}%",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              progressColor: Colors.deepPurple,
              backgroundColor: Colors.grey[300]!,
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
            ),

            const SizedBox(height: 30),

            // Fee values
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _summaryItem("Total", "₹$total"),
                _summaryItem("Paid", "₹$paid", color: Colors.green),
                _summaryItem(
                  "Pending",
                  "₹$pending",
                  color: pending > 0 ? Colors.red : Colors.green,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Status badge
            Chip(
              label: Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: statusColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            ),
          ],
        ),
      ),
    );
  }

  /// Small summary item
  Widget _summaryItem(String title, String value, {Color? color}) {
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
