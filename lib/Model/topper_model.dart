// models/topper_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class TopperModel {
  final String topperId;
  final String title;
  final String subtitle;
  final String imageUrl;
  final DateTime createdAt;

  TopperModel({
    required this.topperId,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.createdAt,
  });

  factory TopperModel.fromMap(Map<String, dynamic> map, String docId) {
    return TopperModel(
      topperId: docId,
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topperId': topperId,
      'title': title,
      'subtitle': subtitle,
      'imageUrl': imageUrl,
      'createdAt': createdAt,
    };
  }
}
