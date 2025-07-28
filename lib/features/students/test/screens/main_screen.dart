// import 'package:club_app/features/quiz/screens/details_screen.dart';
// import 'package:club_app/features/quiz/widgets/quiz_card.dart';
// import 'package:flutter/material.dart';
// import 'package:club_app/features/quiz/services/quiz_services.dart';
// import 'package:club_app/models/quiz_model.dart';
//
// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }
//
// class _MainScreenState extends State<MainScreen> {
//   final QuizServices quizServices = QuizServices();
//
//   List<QuizModel> quizList = [];
//   bool isLoading = true;
//   //
//   @override
//   void initState() {
//     super.initState();
//     fetchQuizzes();
//   }
//
//   void fetchQuizzes() async {
//     quizList = await quizServices.fetchQuizzes(context);
//     setState(() {
//       isLoading = false;
//     });
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Quiz List")),
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : quizList.isEmpty
//               ? const Center(child: Text("⚠ No quizzes available"))
//               : ListView.builder(
//                 itemCount: quizList.length,
//                 itemBuilder: (context, index) {
//                   final quiz = quizList[index];
//                   return GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => QuizDetailsScreen(quiz: quiz)
//                         ),
//                       );
//                     },
//                     child: QuizCard(
//                       title: quiz.title,
//                       subtitle: quiz.category,
//                       difficulty: "easy",
//                     ),
//                   );
//                 },
//               ),
//     );
//   }
// }
