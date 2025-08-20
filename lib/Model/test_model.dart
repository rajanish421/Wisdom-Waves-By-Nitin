




import 'package:cloud_firestore/cloud_firestore.dart';

class TestModel {
  final String testId;
  final String title;
  final String subtitle;
  final String batchName;
  final int totalQuestions;
  final int totalMarks;
  final bool status;
  final DateTime createdAt;
  final int duration; // in minutes

  TestModel({
    required this.testId,
    required this.title,
    required this.subtitle,
    required this.batchName,
    required this.totalQuestions,
    required this.totalMarks,
    required this.status,
    required this.createdAt,
    required this.duration,
  });

  /// Convert Firestore map -> TestModel
  factory TestModel.fromMap(Map<String, dynamic> map) {
    return TestModel(
      testId: map['testId'] ?? '',
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      batchName: map['batchName'] ?? '',
      totalQuestions: (map['totalQuestions'] ?? 0) as int,
      totalMarks: (map['totalMarks'] ?? 0) as int,
      status: (map['status'] ?? false) as bool,
      createdAt: map['createdAt'] != null
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      duration: (map['duration'] ?? 0) as int,
    );
  }

  /// Convert TestModel -> Firestore map
  Map<String, dynamic> toMap() {
    return {
      'testId': testId,
      'title': title,
      'subtitle': subtitle,
      'batchName': batchName,
      'totalQuestions': totalQuestions,
      'totalMarks': totalMarks,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt), // ✅ Important fix
      'duration': duration,
    };
  }
}








//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class TestModel {
//   final String testId;
//   final String title;
//   final String subtitle;
//   final String batchName;
//   final int totalQuestions;
//   final int totalMarks;
//   final bool status;
//   final DateTime createdAt;
//   final int duration; // in minutes
//
//   TestModel({
//     required this.testId,
//     required this.title,
//     required this.subtitle,
//     required this.batchName,
//     required this.totalQuestions,
//     required this.totalMarks,
//     required this.status,
//     required this.createdAt,
//     required this.duration,
//   });
//
//   // Convert Firestore doc -> TestModel
//   factory TestModel.fromMap(Map<String, dynamic> map) {
//     return TestModel(
//       testId: map['testId']??'',
//       title: map['title'] ?? '',
//       subtitle: map['subtitle'] ?? '',
//       batchName: map['batchName'] ?? '',
//       totalQuestions: map['totalQuestions'] ?? 0,
//       totalMarks: map['totalMarks'] ?? 0,
//       status: map['status'] ?? false,
//       createdAt: (map['createdAt'] as Timestamp).toDate(),
//       duration: map['duration'] ?? 0,
//     );
//   }
//
//   // Convert TestModel -> Map for Firestore
//   Map<String, dynamic> toMap() {
//     return {
//       "testId" : testId,
//       'title': title,
//       'subtitle': subtitle,
//       'batchName': batchName,
//       'totalQuestions': totalQuestions,
//       'totalMarks': totalMarks,
//       'status': status,
//       'createdAt': createdAt,
//       'duration': duration,
//     };
//   }
// }
