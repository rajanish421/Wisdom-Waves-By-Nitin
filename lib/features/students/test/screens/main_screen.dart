import 'package:flutter/material.dart';

import '../../../../Model/quiz_model.dart';
import '../services/quiz_services.dart';
import '../widgets/quiz_card.dart';
import 'details_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // final QuizServices quizServices = QuizServices();

  // List<QuizModel> quizList = [];
  bool isLoading = false;

  List<QuizModel> quizList = [
    QuizModel(
      id: '1',
      title: 'Flutter Basics',
      category: 'Mobile Development',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1)),
      questions: [
        Question(
          question: 'What is Flutter?',
          options: ['SDK', 'Library', 'Framework', 'Language'],
          correctAns: 'SDK',
        ),
        Question(
          question: 'Which language is used by Flutter?',
          options: ['Java', 'Kotlin', 'Dart', 'Swift'],
          correctAns: 'Dart',
        ),
      ],
    ),
    QuizModel(
      id: '2',
      title: 'DSA Quiz',
      category: 'Computer Science',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 2)),
      questions: [
        Question(
          question: 'What is the time complexity of binary search?',
          options: ['O(n)', 'O(log n)', 'O(n log n)', 'O(1)'],
          correctAns: 'O(log n)',
        ),
        Question(
          question: 'Which data structure uses FIFO?',
          options: ['Stack', 'Queue', 'Graph', 'Tree'],
          correctAns: 'Queue',
        ),
      ],
    ),
    QuizModel(
      id: '3',
      title: 'GK Quiz',
      category: 'General Knowledge',
      startTime: DateTime.now(),
      endTime: DateTime.now().add(const Duration(hours: 1, minutes: 30)),
      questions: [
        Question(
          question: 'Who is the Prime Minister of India?',
          options: [
            'Narendra Modi',
            'Rahul Gandhi',
            'Arvind Kejriwal',
            'Amit Shah',
          ],
          correctAns: 'Narendra Modi',
        ),
        Question(
          question: 'Which is the longest river in the world?',
          options: ['Amazon', 'Nile', 'Ganga', 'Yangtze'],
          correctAns: 'Nile',
        ),
      ],
    ),
  ];

  //
  // @override
  // void initState() {
  //   super.initState();
  //   fetchQuizzes();
  // }

  // void fetchQuizzes() async {
  //   quizList = await quizServices.fetchQuizzes(context);
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz List")),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : quizList.isEmpty
              ? const Center(child: Text("⚠ No quizzes available"))
              : ListView.builder(
                itemCount: quizList.length,
                itemBuilder: (context, index) {
                  final quiz = quizList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizDetailsScreen(quiz: quiz)
                        ),
                      );
                    },
                    child: QuizCard(
                      title: quiz.title,
                      subtitle: quiz.category,
                      difficulty: "easy",
                    ),
                  );
                },
              ),
    );
  }
}
