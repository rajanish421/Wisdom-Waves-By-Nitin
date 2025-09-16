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
    // QuerySnapshot snapshot = await _firestore.collection('files').get();
    QuerySnapshot snapshot = await _firestore.collection('classes').get();

    return snapshot.docs
        .map((doc) => doc['className'] as String) // unique values
        .toList()..sort((a, b) {
          int numA = int.parse(a);
          int numB = int.parse(b);
          return numA.compareTo(numB);
        },);
  }

  /// ✅ Fetch subjects for a given class
  Future<List<String>> getSubjects(String className) async {
    // QuerySnapshot snapshot = await _firestore
    //     .collection('files')
    //     .where('className', isEqualTo: className)
    //     .get();
    QuerySnapshot snapshot = await _firestore
        .collection('subjects')
        .get();

    return snapshot.docs
        .map((doc) => doc['subjectName'] as String)
        .toSet()
        .toList()..sort((a, b) {
          return a.compareTo(b);
        },);
  }

  /// ✅ Fetch all videos for a given class + subject
  Future<List<UploadModel>> getVideos(String className, String subject) async {
    QuerySnapshot snapshot = await _firestore
        .collection('files')
        .where('className', isEqualTo: className)
        .where('subject', isEqualTo: subject)
        .where('type', isEqualTo: 'video')
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
        .where('type', isEqualTo: 'image')
        .get();

    return snapshot.docs
        .map((doc) => UploadModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}



