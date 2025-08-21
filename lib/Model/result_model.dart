class ResultModel {
  final String resultId;
  final String testId;
  final String userId;
  final String testTitle;
  final int marks;
  final int totalMarks;
  final DateTime attemptDate;

  ResultModel({
    required this.resultId,
    required this.testId,
    required this.userId,
    required this.testTitle,
    required this.marks,
    required this.totalMarks,
    required this.attemptDate,
  });

  // Convert to Map (for Firestore/REST API)
  Map<String, dynamic> toMap() {
    return {
      'resultId': resultId,
      'testId': testId,
      'userId': userId,
      'testTitle': testTitle,
      'marks': marks,
      'totalMarks': totalMarks,
      'attemptDate': attemptDate.toIso8601String(),
    };
  }

  // Convert from Map
  factory ResultModel.fromMap(Map<String, dynamic> map) {
    return ResultModel(
      resultId: map['resultId'] ?? '',
      testId: map['testId'] ?? '',
      userId: map['userId'] ?? '',
      testTitle: map['testTitle'] ?? '',
      marks: map['marks'] ?? 0,
      totalMarks: map['totalMarks'] ?? 0,
      attemptDate: DateTime.parse(map['attemptDate']),
    );
  }
}
