// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../../Model/file_model.dart';
//

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../Model/file_model.dart';

class FileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// ✅ Fetch all classes (distinct className values)
  Future<List<String>> getClasses() async {
    QuerySnapshot snapshot = await _firestore.collection('files').get();
    return snapshot.docs
        .map((doc) => doc['className'] as String)
        .toSet() // unique values
        .toList();
  }

  /// ✅ Fetch subjects for a given class
  Future<List<String>> getSubjects(String className) async {
    QuerySnapshot snapshot = await _firestore
        .collection('files')
        .where('className', isEqualTo: className)
        .get();

    return snapshot.docs
        .map((doc) => doc['subject'] as String)
        .toSet()
        .toList();
  }

  /// ✅ Fetch all videos for a given class + subject
  Future<List<UploadModel>> getVideos(String className, String subject) async {
    QuerySnapshot snapshot = await _firestore
        .collection('files')
        .where('className', isEqualTo: className)
        .where('subject', isEqualTo: subject)
        .where('type', isEqualTo: 'videos')
        .get();

    return snapshot.docs
        .map((doc) => UploadModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// ✅ Fetch all PDFs for a given class + subject
  Future<List<UploadModel>> getPdfs(String className, String subject) async {
    QuerySnapshot snapshot = await _firestore
        .collection('files')
        .where('className', isEqualTo: className)
        .where('subject', isEqualTo: subject)
        .where('type', isEqualTo: 'pdf')
        .get();

    return snapshot.docs
        .map((doc) => UploadModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  /// ✅ Fetch all Images for a given class + subject
  Future<List<UploadModel>> getImages(String className, String subject) async {
    QuerySnapshot snapshot = await _firestore
        .collection('files')
        .where('className', isEqualTo: className)
        .where('subject', isEqualTo: subject)
        .where('type', isEqualTo: 'images')
        .get();

    return snapshot.docs
        .map((doc) => UploadModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}








// class FileService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   /// Fetch all classes (distinct className values)
//   Future<List<String>> getClasses() async {
//     QuerySnapshot snapshot = await _firestore.collection('files').get();
//     return snapshot.docs
//         .map((doc) => doc['className'] as String)
//         .toSet() // unique values
//         .toList();
//   }
//
//   /// Fetch subjects for a given class
//   Future<List<String>> getSubjects(String className) async {
//     QuerySnapshot snapshot = await _firestore
//         .collection('files')
//         .where('className', isEqualTo: className)
//         .get();
//
//     return snapshot.docs
//         .map((doc) => doc['subject'] as String)
//         .toSet()
//         .toList();
//   }
//
//   /// Fetch all videos for a given class + subject
//   Future<List<UploadModel>> getVideos(String className, String subject) async {
//     QuerySnapshot snapshot = await _firestore
//         .collection('files')
//         .where('className', isEqualTo: className)
//         .where('subject', isEqualTo: subject)
//         .where('type', isEqualTo: 'videos')
//         .get();
//
//     return snapshot.docs
//         .map((doc) => UploadModel.fromMap(doc.data() as Map<String, dynamic>))
//         .toList();
//   }
// }
