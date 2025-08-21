import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom_waves_by_nitin/Custom_Widget/button.dart';
import 'package:wisdom_waves_by_nitin/Model/question_model.dart';
import 'package:wisdom_waves_by_nitin/Model/result_model.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/students/test/screens/resuiltScreen.dart';

import '../../../../Model/quiz_model.dart';
import '../../../../Model/test_model.dart';

class QuizScreen extends StatefulWidget {
  final TestModel test;
  final int index;

  const QuizScreen({super.key, required this.test,required this.index});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final List<Question> questions = [];
  int currentQueIndex = 0;

  // QuizServices quizServices = QuizServices();
  int sum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getQue();
  }

  // void getQue() {
  //   for (int i = 0; i < widget.quiz.questions.length; i++) {
  //     questions.add(widget.quiz.questions[i]);
  //   }
  //   print(questions.length);
  // }

  int? selectedOpt;

  void nextQuestion(int index, String correctAnswer) {
    // if (questions[currentQueIndex].options[index] == correctAnswer) {
    //   sum++;
    // }
    // setState(() {
    currentQueIndex++;
    selectedOpt = -1;
    // });
  }

  void finishQuiz() async {

    SharedPreferences pref = await  SharedPreferences.getInstance();
    final userId = await pref.getString("userId");
    print(userId);
    final docRef = firestore.collection("tests").doc(widget.test.testId).collection("results").doc();

    final result = ResultModel(resultId: docRef.id, testId: widget.test.testId, userId:userId.toString(), testTitle: widget.test.title, marks: sum, totalMarks: widget.test.totalMarks, attemptDate: DateTime.now());

        docRef.set(result.toMap());
  }
    // if (questions[currentQueIndex].options[index] == ans) {
    //   sum++;
    // }
    // store result in database
    // await quizServices.saveAttempt(context, widget.quiz.id!, sum, widget.quiz.category, widget.quiz.questions.length, true);
    // await  quizServices.saveResult(
    //   context: context,
    //   quizId: widget.quiz.id!,
    //   score: sum,
    //   totalQue: widget.quiz.questions.length,
    //   category: widget.quiz.category,
    // );

    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(
    //     builder:
    //         (context) =>
    //         ResuiltScreen(score: sum, totalQuestion: widget.questions.length),
    //   ),
    // );
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Test Time ✨"),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance
                .collection("tests")
                .doc(widget.test.testId)
                .collection("questions")
                .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          //
          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return const Center(child: CircularProgressIndicator());
          // }
          //
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No Question Available"));
          }

          final data =
              snapshot.data!.docs
                  .map((doc) => QuestionModel.fromMap(doc.data()))
                  .toList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16,
                ),
                child: Text("Q${currentQueIndex+1}: ${data[currentQueIndex].question}",
                  style: TextStyle(fontSize: 22,color: Colors.black54),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: data[currentQueIndex].options.length,
                    itemBuilder: (context, index) {
                      bool isSelected = selectedOpt == index;
                      return GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedOpt = index;
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? AppColors.appBarColor
                                    : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                            border: Border.all(color: AppColors.appBarColor),
                          ),
                          child: Text(
                            data[currentQueIndex].options[index],
                            style: TextStyle(
                              fontSize: 18,
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(text: currentQueIndex == data.length -1 ? "Submit":"Next", onPressed: (){
                  if(selectedOpt == data[currentQueIndex].correctIndex){
                    sum++;
                  }


                  if(selectedOpt != -1) {
                    setState((){
                      if (currentQueIndex < data.length - 1) {
                        print(sum);
                        currentQueIndex++;
                        selectedOpt = -1;
                      }else{
                       finishQuiz();
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => ResuiltScreen(score: sum,totalQuestion: data.length,),));
                      }

                    });
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select an option"),),);
                  }

                }),
              ),
              SizedBox(height: 20,),

            ],
          );

          // return Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.stretch,
          //     children: [
          //       Text(
          //         "Q${currentQueIndex + 1}. ${question[currentQueIndex].question}",
          //         style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          //       ),
          //       const SizedBox(height: 20),
          //       Expanded(
          //         child: ListView.builder(
          //           physics: NeverScrollableScrollPhysics(),
          //           itemCount: question[currentQueIndex].options.length,
          //           itemBuilder: (context, index) {
          //             bool isSelected = selectedOpt == index;
          //             return GestureDetector(
          //               onTap: () {
          //                 setState(() {
          //                   // tempSelectedAnswer = option;
          //                   selectedOpt = index;
          //                   print(index);
          //                 });
          //               },
          //               child: Container(
          //                 margin: const EdgeInsets.symmetric(vertical: 8),
          //                 padding: const EdgeInsets.all(16),
          //                 decoration: BoxDecoration(
          //                   color: isSelected ? AppColors.appBarColor : Colors.white,
          //                   borderRadius: BorderRadius.circular(12),
          //                   boxShadow: [
          //                     BoxShadow(
          //                       color: Colors.black.withOpacity(0.05),
          //                       blurRadius: 6,
          //                       offset: const Offset(0, 3),
          //                     ),
          //                   ],
          //                   border: Border.all(color: AppColors.appBarColor),
          //                 ),
          //                 child: Text(
          //                   question[currentQueIndex].options[index],
          //                   style: TextStyle(
          //                     fontSize: 18,
          //                     color: isSelected ? Colors.white : Colors.black87,
          //                     fontWeight: FontWeight.w500,
          //                   ),
          //                 ),
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //       const Spacer(),
          //       ElevatedButton(
          //         onPressed: () {
          //           selectedOpt == null
          //               ? null
          //               : currentQueIndex == questions.length - 1
          //               ? finishQuiz(selectedOpt!, question[currentQueIndex].question)
          //               : nextQuestion(selectedOpt!,questions[currentQueIndex].correctAns);
          //         },
          //         style: ElevatedButton.styleFrom(
          //           padding: const EdgeInsets.symmetric(vertical: 14),
          //           backgroundColor: AppColors.appBarColor,
          //           shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(12),
          //           ),
          //         ),
          //         child: Text(
          //           currentQueIndex == questions.length - 1
          //               ? "Finish Quiz"
          //               : "Next",
          //           style: const TextStyle(fontSize: 18),
          //         ),
          //       ),
          //     ],
          //   ),
          // );
        },
      ),
    );
  }
}
