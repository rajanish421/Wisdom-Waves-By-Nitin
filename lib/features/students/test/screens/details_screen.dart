import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom_waves_by_nitin/Model/test_model.dart';
import 'package:wisdom_waves_by_nitin/features/students/test/screens/QuestionScreen.dart';
import 'package:wisdom_waves_by_nitin/utills/show_message_dialogue.dart';


class QuizDetailsScreen extends StatefulWidget {
  final int index;
  final TestModel test;

  const QuizDetailsScreen({super.key, required this.test, required this.index});

  @override
  State<QuizDetailsScreen> createState() => _QuizDetailsScreenState();
}

class _QuizDetailsScreenState extends State<QuizDetailsScreen> {
  int? score;
  bool isAttempt = false;
  bool isActive = false;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<bool> isTestLive() async {
    DocumentSnapshot res =
        await firestore.collection("tests").doc(widget.test.testId).get();
    return res.get("status");
  }

  Future<bool> isAttempted() async {
    final pref = await SharedPreferences.getInstance();
    final userId = pref.getString("userId");

    if (userId == null) return false; // safety check

    QuerySnapshot res =
        await FirebaseFirestore.instance
            .collection("tests")
            .doc(widget.test.testId)
            .collection("results")
            .where("userId", isEqualTo: userId)
            .limit(1) // limit for efficiency
            .get();

    if (res.docs.isNotEmpty) {
      var data = res.docs.first.data() as Map<String, dynamic>;
      print("Result Data: ${res.docs.first.data()}");

      int marks = data["marks"];
      score = marks;
      return true;
    }
    return false;
  }


  void getData() async {
    isActive = await isTestLive();
    isAttempt = await isAttempted();
   setState(() {
   });
    print(isAttempt);
    print(isActive);
    print(score);
  }

  @override
  void initState() {
    super.initState();
    getData();

  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📝 Test Details',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E3A8A), Color(0xFF2563EB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "🔥 ${widget.test.title}",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Batch :  ${widget.test.batchName}",
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.timer_sharp, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "Duration: ${widget.test.duration} minutes",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.help_outline, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          "Questions: 12",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: isActive?Colors.green:Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(blurRadius: 1, color: Colors.grey),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(
                            8.0,
                          ).copyWith(left: 16, right: 16),
                          child: Text(
                           isActive? "Active":"Inactive",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Your Score",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            score == null ? "" : score.toString(),
                            style: TextStyle(
                              fontSize: 40,
                              color: Colors.yellowAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if(isAttempt){
                      showMessageDialog(context: context, title: "Test", message: "Already Attempted",isSuccess: false);
                      return;
                    }else if(!isActive){
                      showMessageDialog(context: context, title: "Test", message: "Test is inactive",isSuccess: false);
                      return;
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => QuizScreen(
                              test: widget.test,
                              index: widget.index,
                            ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isActive
                            ? Colors.green
                            : Colors.grey.shade800,
                    disabledBackgroundColor: Colors.grey.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Start Test",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// String formatTime(DateTime time) {
//   return DateFormat('MMM dd, yyyy · hh:mm a').format(time);
// }
