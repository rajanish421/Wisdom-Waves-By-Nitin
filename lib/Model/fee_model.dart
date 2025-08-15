import 'package:flutter/material.dart';

class Fee {
  String feeId;
  String name;
  String userId;
  int totalFee;
  String dueFee;
  Map<String, dynamic> lastPayment;
  String batch;
  List<Map<String, dynamic>> payments;

  Fee({
    this.payments = const [],
    required this.userId,
    required this.feeId,
    this.dueFee = "0",
    Map<String, dynamic>? lastPayment,
    required this.totalFee,
    required this.batch,
    required this.name,
  }) : lastPayment = lastPayment ??
      {
        "amount": "0",
        "paidAt": DateTime.now(),
      };

  /// Converts a Fee object into a Map.
  Map<String, dynamic> toMap() {
    return {
      'feeId': feeId,
      'userId': userId,
      'totalFee': totalFee,
      'dueFee': dueFee,
      'lastPayment': lastPayment,
      'payments': payments,
      'batch': batch,
      'name': name,
    };
  }

  /// Creates a Fee object from a Map.
  factory Fee.fromMap(Map<String, dynamic> map) {
    return Fee(
      feeId: map['feeId'] ?? '',
      userId: map['userId'] ?? '',
      totalFee: (map['totalFee'] ?? 0).toInt(),
      dueFee: (map['dueFee'] ?? "0"),
      lastPayment: map['lastPayment'] != null
          ? Map<String, dynamic>.from(map['lastPayment'])
          : {
        "amount": "0",
        "paidAt": DateTime.now(),
      },
      payments: List<Map<String, dynamic>>.from(map['payments'] ?? []),
      batch: map['batch'] ?? '',
      name: map['name'] ?? '',
    );
  }
}













// import 'package:flutter/material.dart';
//
// class Fee {
//   String feeId;
//   String name;
//   String userId;
//   int totalFee;
//   int dueFee;
//   Map<int, dynamic>? lastPayment;
//   String batch;
//   List<Map<String, dynamic>> payments;
//
//   Fee({
//     this.payments = const [],
//     required this.userId,
//     required this.feeId,
//     this.dueFee = 0,
//      this.lastPayment ,
//     required this.totalFee,
//     required this.batch,
//     required this.name,
//   });
//
//   /// Converts a Fee object into a Map.
//   Map<String, dynamic> toMap() {
//     return {
//       'feeId': feeId,
//       'userId': userId,
//       'totalFee': totalFee,
//       'dueFee': dueFee,
//       'lastPayment': lastPayment,
//       'payments': payments,
//       'batch' : batch,
//       'name' : name,
//     };
//   }
//
//   /// Creates a Fee object from a Map.
//   factory Fee.fromMap(Map<String, dynamic> map) {
//     return Fee(
//       feeId: map['feeId'] ?? '',
//       userId: map['userId'] ?? '',
//       totalFee: map['totalFee']?.toInt() ?? 0,
//       dueFee: map['dueFee']?.toInt() ?? 0,
//       lastPayment: map['lastPayment'] != null
//           ? Map<int, dynamic>.from(map['lastPayment'])
//           : {},
//       payments: List<Map<String, dynamic>>.from(map['payments'] ?? []),
//       batch: map['batch']??'',
//       name: map['name']??'',
//     );
//   }
// }
//
//
// // class Payment{
// //   int amount;
// //   DateTime paidAt;
// //
// //   Payment({required this.amount,required this.paidAt});
// // }