import 'package:cloud_firestore/cloud_firestore.dart';

class DiscussionMessage {
  final String? id;
  final String senderId;
  final String senderName;
  final String? text;
  final String? imageUrl;
  final String? audioUrl;
  final int? audioDuration; // in seconds
  final DateTime? timestamp;

  DiscussionMessage({
    this.id,
    required this.senderId,
    required this.senderName,
    this.text,
    this.imageUrl,
    this.audioUrl,
    this.audioDuration,
    this.timestamp,
  });

  Map<String, dynamic> toFirestoreMap() {
    return {
      'id':id,
      'senderId': senderId,
      'senderName': senderName,
      'text': text,
      'imageUrl': imageUrl,
      'audioUrl': audioUrl,
      'audioDuration': audioDuration,
      'type': _resolveType(),
      'timestamp': FieldValue.serverTimestamp(),
    };
  }

  String _resolveType() {
    final hasText = text != null && text!.trim().isNotEmpty;
    if (imageUrl != null && audioUrl != null && hasText) return 'mixed';
    if (imageUrl != null && audioUrl != null) return 'image_audio';
    if (imageUrl != null && hasText) return 'image_text';
    if (audioUrl != null && hasText) return 'audio_text';
    if (imageUrl != null) return 'image';
    if (audioUrl != null) return 'audio';
    return 'text';
  }

  factory DiscussionMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final ts = data['timestamp'] as Timestamp?;
    return DiscussionMessage(
      id: data['id'],
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      text: data['text'] as String?,
      imageUrl: data['imageUrl'] as String?,
      audioUrl: data['audioUrl'] as String?,
      audioDuration: data['audioDuration'] as int?,
      timestamp: ts?.toDate(),
    );
  }
}
