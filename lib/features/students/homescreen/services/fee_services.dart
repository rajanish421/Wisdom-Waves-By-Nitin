import 'package:cloud_firestore/cloud_firestore.dart';

class StudentFeeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Stream for student's fee document
  Stream<DocumentSnapshot<Map<String, dynamic>>> getStudentFee(String userId) {
    return _firestore
        .collection("fee")
        .where("userId", isEqualTo: userId)
        .limit(1)
        .snapshots()
        .map((snapshot) => snapshot.docs.first);
  }

  /// 🔹 Stream for monthly fee history
  Stream<QuerySnapshot<Map<String, dynamic>>> getStudentFeeMonths(String feeId) {
    return _firestore
        .collection("fee")
        .doc(feeId)
        .collection("months")
        .orderBy("month")
        .snapshots();
  }
}
