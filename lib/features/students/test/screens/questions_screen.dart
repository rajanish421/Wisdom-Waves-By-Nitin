// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../../Model/question_model.dart';
//
// class QuestionsScreen extends StatelessWidget {
//   const QuestionsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Quiz Questions")),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('questions').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return const Center(child: Text("Something went wrong"));
//           }
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//
//           final questions = snapshot.data!.docs
//               .map((doc) => QuestionModel.fromMap(doc.))
//               .toList();
//
//           return ListView.builder(
//             itemCount: questions.length,
//             itemBuilder: (context, index) {
//               final q = questions[index];
//               return Card(
//                 margin: const EdgeInsets.all(10),
//                 child: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(q.question, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                       const SizedBox(height: 10),
//                       ...q.options.map((opt) => ListTile(
//                         title: Text(opt),
//                         leading: const Icon(Icons.circle_outlined),
//                       )),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
