import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdom_waves_by_nitin/Model/fee_model.dart';
class StudentFeeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// 🔹 Stream for student's fee document
  Stream<FeeModel?> getStudentFee(String userId) {
    return _firestore
        .collection("fee")
        .doc(userId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      if (data != null) {
        return FeeModel.fromMap(data);
      }
      return null; // 🔹 return null if doc doesn't exist
    });
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
