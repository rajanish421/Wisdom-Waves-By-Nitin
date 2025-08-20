import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Model/test_model.dart';
import 'package:wisdom_waves_by_nitin/features/students/test/screens/QuestionScreen.dart';

import '../../../../Model/quiz_model.dart';
import '../../../../comman/widgets/show_snack_bar.dart';
import '../services/quiz_services.dart';

class QuizDetailsScreen extends StatefulWidget {
  final int index;
  final TestModel test;
  const QuizDetailsScreen({super.key,required this.test,required this.index});

  @override
  State<QuizDetailsScreen> createState() => _QuizDetailsScreenState();
}

class _QuizDetailsScreenState extends State<QuizDetailsScreen> {
  int? score;

// QuizServices quizServices = QuizServices();
  // void startTimer() {
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     if (countdownDuration.inSeconds == 0) {
  //       _timer.cancel();
  //     } else {
  //       setState(() {
  //         countdownDuration -= const Duration(seconds: 1);
  //       });
  //     }
  //   });
  // }
 // Future<bool> isAttempted()async{
 //   final res = await quizServices.checkAttempt(quizId: widget.quiz.id!);
 //   print(res);
 //    if(res){
 //      return true;
 //    }else{
 //      return false;
 //    }
 // }

  void isQuizLive() {
    // int startTime = widget.quiz.startTime.toUtc().millisecondsSinceEpoch;
    // int endTime = widget.quiz.endTime.toUtc().millisecondsSinceEpoch;
    // endTime);
    // print(currentTime);    int currentTime = DateTime.now().millisecondsSinceEpoch;
    // print(startTime);
    // print(

    // if (currentTime>=startTime && currentTime <=endTime) {
    //   print("✅ Quiz is OPEN");
    // } else {
    //   print("❌ Quiz is CLOSED");
    // }


  }


  // @override
  // void initState() {
  //   super.initState();
  //   // startTimer();
  //   isQuizLive();
  //   getScore();
  // }

  // void getScore()async{
  //  final res = await quizServices.getScore(quizId: widget.quiz.id!);
  //   score = res;
  //   setState(() {
  //   });
  // }


  @override
  void dispose() {
    super.dispose();
  }

  String formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {

    final time = false;
    print('------------------------------');
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '📝 Quiz Details',
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
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.test.batchName,
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.timer_sharp, color: Colors.white),
                        const SizedBox(width: 8),
                        Text("Duration: ${widget.test.duration}", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.timer_off, color: Colors.white),
                        const SizedBox(width: 8),
                        Text("End : ", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.help_outline, color: Colors.white),
                        const SizedBox(width: 8),
                        Text("Questions: 12", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "Your Score",
                            style: TextStyle(fontSize: 16, color: Colors.white70),
                          ),
                          const SizedBox(height: 8),
                          Text(
                             score == null?"":score.toString(),
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
                  onPressed:() async {

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizScreen(testId: widget.test.testId,index:widget.index),));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:time? Colors.greenAccent.shade400:Colors.grey.shade800,
                    disabledBackgroundColor: Colors.grey.shade800,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                     "Start Quiz",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              )
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
