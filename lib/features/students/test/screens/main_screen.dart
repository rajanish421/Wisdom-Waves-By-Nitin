import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../Model/quiz_model.dart';
import '../../../../Model/test_model.dart';
import '../services/quiz_services.dart';
import '../widgets/quiz_card.dart';
import 'details_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Test List")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("tests").snapshots(), builder: (context, snapshot) {

         if (snapshot.hasError) {
           return const Center(child: Text("Something went wrong"));
         }

         if (snapshot.connectionState == ConnectionState.waiting) {
           return const Center(child: CircularProgressIndicator());
         }

         if (!snapshot.hasData) {
           return const Center(child: Text("No Test Available"));
         }
         final tests = snapshot.data!.docs
             .map((doc) => TestModel.fromMap(doc.data()))
             .toList();
         return ListView.builder(
           itemCount: tests.length,
           itemBuilder: (context, index) {
             final test = tests[index];
             return GestureDetector(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => QuizDetailsScreen(test: test,index: index),
                   ),
                 );
               },
               child: QuizCard(
                 title: test.title,
                 subtitle: test.batchName,
                 difficulty: "easy",
               ),
             );
           },
         );
       },)
    );
  }
}
