import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/features/students/test/screens/resuiltScreen.dart';

import '../../../../Model/quiz_model.dart';

class QuizScreen extends StatefulWidget {
  final QuizModel quiz;

  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Question> questions = [];
  int currentQueIndex = 0;

  // QuizServices quizServices = QuizServices();
  int sum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQue();
  }

  void getQue() {
    for (int i = 0; i < widget.quiz.questions.length; i++) {
      questions.add(widget.quiz.questions[i]);
    }
    print(questions.length);
  }

  int? selectedOpt;

  void nextQuestion(int index, String ans) {
    if (questions[currentQueIndex].options[index] == ans) {
      sum++;
    }
    setState(() {
      currentQueIndex++;
      selectedOpt = -1;
    });
  }

  void finishQuiz(int index, String ans) async {
    if (questions[currentQueIndex].options[index] == ans) {
      sum++;
    }
    // store result in database
    // await quizServices.saveAttempt(context, widget.quiz.id!, sum, widget.quiz.category, widget.quiz.questions.length, true);
    // await  quizServices.saveResult(
    //   context: context,
    //   quizId: widget.quiz.id!,
    //   score: sum,
    //   totalQue: widget.quiz.questions.length,
    //   category: widget.quiz.category,
    // );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
            ResuiltScreen(score: sum, totalQuestion: widget.quiz.questions.length),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQueIndex];
    final List<String> options = question.options;
    // final question = questions[currentQuestionIndex];
    // final options = question["options"] as List<String>;
    print(sum);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text("Quiz Time ✨"),
        backgroundColor: AppColors.appBarColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Q${currentQueIndex + 1}. ${question.question}",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: options.length,
                itemBuilder: (context, index) {
                  bool isSelected = selectedOpt == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        // tempSelectedAnswer = option;
                        selectedOpt = index;
                        print(index);
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.appBarColor : Colors.white,
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
                        options[index],
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
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                selectedOpt == null
                    ? null
                    : currentQueIndex == questions.length - 1
                    ? finishQuiz(selectedOpt!, question.correctAns)
                    : nextQuestion(selectedOpt!, question.correctAns);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: AppColors.appBarColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                currentQueIndex == questions.length - 1
                    ? "Finish Quiz"
                    : "Next",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
