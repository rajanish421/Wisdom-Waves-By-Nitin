import 'dart:convert';
import 'package:flutter/material.dart';

class Students {
  // Fields
  final String userId;
  final String uid;     // for user edit/delete from firebase Auth
  final String name;
  final String gender;
  final int age;
  final String std;
  final String batch;
  final String medium;
  final String school_name;
  final int contact_number;
  final String father_name;
  final String mother_name;
  final String address;
  final String? profile_url;
  final String role;
  final dynamic createdAt;

  // Constructor
  Students({
    required this.userId,
    required this.uid,
    required this.name,
    required this.gender,
    required this.std,
    required this.batch,
    required this.medium,
    required this.school_name,
    required this.address,
    required this.contact_number,
    required this.father_name,
    required this.mother_name,
    required this.age,
    this.profile_url = "",
    this.role = "students",
    required this.createdAt,
  });

  // Convert Students to Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'uid' : uid,
      'name': name,
      'gender': gender,
      'age': age,
      'std': std,
      'batch': batch,
      'medium': medium,
      'school_name': school_name,
      'contact_number': contact_number,
      'father_name': father_name,
      'mother_name': mother_name,
      'address': address,
      'profile_url': profile_url,
      'role': role,
      'createdAt': createdAt,
    };
  }

  // From Map to Students
  factory Students.fromMap(Map<String, dynamic> map) {
    return Students(
      userId: map['userId'] ?? '',
      uid: map['uid']??'',
      name: map['name'] ?? '',
      gender: map['gender'] ?? '',
      std: map['std'] ?? '',
      batch: map['batch'] ?? '',
      medium: map['medium'] ?? '',
      school_name: map['school_name'] ?? '',
      address: map['address'] ?? '',
      contact_number: map['contact_number'] ?? 0,
      father_name: map['father_name'] ?? '',
      mother_name: map['mother_name'] ?? '',
      age: map['age'] ?? 0,
      profile_url: map['profile_url'] ?? '',
      role: map['role'] ?? 'students',
      createdAt: map['createdAt']?? '',
    );
  }

  // Convert Students to JSON String
  String toJson() => json.encode(toMap());

  // From JSON String to Students
  factory Students.fromJson(String source) =>
      Students.fromMap(json.decode(source));

  // CopyWith for immutability
  Students copyWith({
    String? userId,
    String? uid,
    String? name,
    String? gender,
    int? age,
    String? std,
    String? batch,
    String? medium,
    String? school_name,
    int? contact_number,
    String? father_name,
    String? mother_name,
    String? address,
    String? profile_url,
    String? role,
    dynamic? createdAt,
  }) {
    return Students(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      std: std ?? this.std,
      batch: batch ?? this.batch,
      medium: medium ?? this.medium,
      school_name: school_name ?? this.school_name,
      contact_number: contact_number ?? this.contact_number,
      father_name: father_name ?? this.father_name,
      mother_name: mother_name ?? this.mother_name,
      address: address ?? this.address,
      profile_url: profile_url ?? this.profile_url,
      role: role ?? this.role,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
