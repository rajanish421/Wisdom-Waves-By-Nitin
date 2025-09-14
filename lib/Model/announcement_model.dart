import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  final String announcementId;
  final String title;
  final String message;
  final String? imageUrl;
  final DateTime createdAt;

  Announcement({
    required this.announcementId,
    required this.title,
    required this.message,
    this.imageUrl,
    required this.createdAt,
  });

  factory Announcement.fromMap(Map<String, dynamic> data) {
    return Announcement(
      announcementId: data['announcementId'] ?? '',
      title: data['title'] ?? '',
      message: data['message'] ?? '',
      imageUrl: data['imageUrl'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "announcementId": announcementId,
      "title": title,
      "message": message,
      "imageUrl": imageUrl,
      "createdAt": createdAt,
    };
  }
}
