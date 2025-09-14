import 'package:cloud_firestore/cloud_firestore.dart';

class FeedbackModel {
  final String id;
  final String name;
  final String message;
  final DateTime createdAt;

  FeedbackModel({
    required this.id,
    required this.name,
    required this.message,
    required this.createdAt,
  });

  // Convert Firestore/JSON to Model
  factory FeedbackModel.fromMap(Map<String, dynamic> map) {
    return FeedbackModel(
      id: map['id'],
      name: map['name'] ?? '',
      message: map['message'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  // Convert Model to Map for Firestore/JSON
  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'name': name,
      'message': message,
      'createdAt': createdAt,
    };
  }
}
