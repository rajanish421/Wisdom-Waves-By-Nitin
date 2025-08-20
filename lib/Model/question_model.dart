class QuestionModel {
  // final String id;
  final String question;
  final List<String> options; // [A, B, C, D]
  final int correctIndex; // 0-3

  QuestionModel({
    // required this.id,
    required this.question,
    required this.options,
    required this.correctIndex,
  });

  // Convert Firestore doc -> QuestionModel
  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      // id: docId,
      question: map['question'] ?? '',
      options: List<String>.from(map['options'] ?? []),
      correctIndex: (map['correctIndex'] ?? 0) as int,
    );
  }

  // Convert QuestionModel -> Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'options': options,
      'correctIndex': correctIndex,
    };
  }
}