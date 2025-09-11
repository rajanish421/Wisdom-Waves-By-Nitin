import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // ✅ only if you use Firestore

class UploadModel {
  final String name;      // File name
  final String type;      // pdf, images, videos
  final String className; // e.g., class10
  final String subject;   // e.g., Math
  final String url;       // Cloudinary URL
  final DateTime createdAt;

  UploadModel({
    required this.name,
    required this.type,
    required this.className,
    required this.subject,
    required this.url,
    required this.createdAt,
  });

  /// ✅ Convert model to map (Firestore safe)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'className': className,
      'subject': subject,
      'url': url,
      'createdAt': createdAt, // Firestore can store DateTime directly
    };
  }

  /// ✅ Create model from Firestore or local map
  factory UploadModel.fromMap(Map<String, dynamic> map) {
    return UploadModel(
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      className: map['className'] ?? '',
      subject: map['subject'] ?? '',
      url: map['url'] ?? '',
      createdAt: map['createdAt'] is Timestamp
          ? (map['createdAt'] as Timestamp).toDate() // Firestore
          : DateTime.parse(map['createdAt'].toString()), // Local String/DateTime
    );
  }
}