// import 'package:cloud_firestore/cloud_firestore.dart';
// import '../models/upload_model.dart';
//
//
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//
//   Stream<List<String>> classesStream() {
// // We assume there's a collection 'classes' or we derive classes from existing files
// // If you keep classes as documents, use another collection. For now derive unique className from 'files'.
//     return _db.collection('files').snapshots().map((snapshot) {
//       final set = <String>{};
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         if (data['className'] != null) set.add(data['className']);
//       }
//       return set.toList();
//     });
//   }
//
//
//   Stream<List<String>> subjectsStream(String className) {
//     return _db
//         .collection('files')
//         .where('className', isEqualTo: className)
//         .snapshots()
//         .map((snapshot) {
//       final set = <String>{};
//       for (var doc in snapshot.docs) {
//         final data = doc.data();
//         if (data['subject'] != null) set.add(data['subject']);
//       }
//       return set.toList();
//     });
//   }
//
//
//   Stream<List<UploadModel>> videosFor(String className, String subject) {
//     return _db
//         .collection('files')
//         .where('className', isEqualTo: className)
//         .where('subject', isEqualTo: subject)
//         .orderBy('createdAt', descending: true)
//         .snapshots()
//         .map((snap) => snap.docs.map((d) => UploadModel.fromMap(d.data())).toList());
//   }
// }