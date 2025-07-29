



class QuizModel {
  final String? id; // optional because MongoDB generates it
  final String title;
  final String category;
  final DateTime startTime;
  final DateTime endTime;
  final List<Question> questions;

  QuizModel({
    this.id,
    required this.title,
    required this.category,
    required this.startTime,
    required this.endTime,
    required this.questions,
  });

  // 🔁 From JSON (for fetching)
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['_id']?.toString(), // null-safe, just in case
      title: json['title'] ?? 'No Title',
      category: json['category'] ?? 'Uncategorized',
      startTime: DateTime.tryParse(json['start_time'] ?? '') ?? DateTime.now(),
      endTime: DateTime.tryParse(json['end_time'] ?? '') ?? DateTime.now(),
      questions: (json['questions'] as List? ?? [])
          .map((q) => Question.fromJson(q))
          .toList(),
    );
  }

  // 🔁 To JSON (for sending)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'start_time': startTime.toIso8601String(),
      'end_time': endTime.toIso8601String(),
      'questions': questions.map((q) => q.toJson()).toList(),
    };
    // `_id` left out intentionally so MongoDB generates it
  }
}

class Question {
  final String question;
  final List<String> options;
  final String correctAns;

  Question({
    required this.question,
    required this.options,
    required this.correctAns,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'] ?? 'No question',
      options: List<String>.from(json['options'] ?? []),
      correctAns: json['correct_ans'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct_ans': correctAns,
    };
  }
}

// class QuizModel {
//   final String? id; // make optional for new quiz insertions
//   final String title;
//   final String category;
//   final DateTime startTime;
//   final DateTime endTime;
//   final List<Question> questions;
//
//   QuizModel({
//     this.id,
//     required this.title,
//     required this.category,
//     required this.startTime,
//     required this.endTime,
//     required this.questions,
//   });
//
//   // 🔁 From JSON (for fetching)
//   factory QuizModel.fromJson(Map<String, dynamic> json) {
//     return QuizModel(
//       id: json['_id'],
//       title: json['title'],
//       category: json['category'],
//       startTime: DateTime.parse(json['start_time']),
//       endTime: DateTime.parse(json['end_time']),
//       questions: (json['questions'] as List)
//           .map((q) => Question.fromJson(q))
//           .toList(),
//     );
//   }
//
//   // 🔁 To JSON (for sending)
//   Map<String, dynamic> toJson() {
//     return {
//       'title': title,
//       'category': category,
//       'start_time': startTime.toIso8601String(),
//       'end_time': endTime.toIso8601String(),
//       'questions': questions.map((q) => q.toJson()).toList(),
//     };
//     // ⚠️ `_id` is intentionally left out here so MongoDB can generate it
//   }
// }
//
// class Question {
//   final String question;
//   final List<String> options;
//   final String correctAns;
//
//   Question({
//     required this.question,
//     required this.options,
//     required this.correctAns,
//   });
//
//   factory Question.fromJson(Map<String, dynamic> json) {
//     return Question(
//       question: json['question'],
//       options: List<String>.from(json['options']),
//       correctAns: json['correct_ans'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'question': question,
//       'options': options,
//       'correct_ans': correctAns,
//     };
//   }
// }
