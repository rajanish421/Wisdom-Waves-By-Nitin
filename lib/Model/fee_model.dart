
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class FeeModel {
  final String feeId;
  final String lastPayMonthId;
  final int lastPaymentMonth;
  final String userId;
  final String batchId;
  final int batchFee;   // Monthly fee amount
  final int totalPaid;  // Total amount paid
  final int totalDue;   // Total amount still due
  final bool userStatus;

  FeeModel({
    required this.feeId,
    required this.lastPayMonthId,
    required this.lastPaymentMonth,
    required this.userId,
    required this.batchId,
    required this.batchFee,
    required this.totalPaid,
    required this.totalDue,
    this.userStatus = true,
  });

  /// Convert object -> Firestore
  Map<String, dynamic> toMap() {
    return {
      "feeId": feeId,
      "lastPayMonthId":lastPayMonthId,
      'lastPaymentMonth':lastPaymentMonth,
      "userId": userId,
      "batchId": batchId,
      "batchFee": batchFee,
      "totalPaid": totalPaid,
      "totalDue": totalDue,
      "userStatus":userStatus,
    };
  }

  /// Convert Firestore -> object
  factory FeeModel.fromMap(Map<String, dynamic> map) {
    return FeeModel(
      feeId: map["feeId"] ?? "",
      lastPayMonthId: map["lastPayMonthId"]??"",
      lastPaymentMonth: map['lastPaymentMonth']??0,
      userId: map["userId"] ?? "",
      batchId: map["batchId"] ?? "",
      batchFee: map["batchFee"] ?? 0,
      totalPaid: map["totalPaid"] ?? 0,
      totalDue: map["totalDue"] ?? 0,
      userStatus: map["userStatus"]??true,
    );
  }
}





class FeeMonth {
  final String monthId;     // e.g., "2025-05"
  final int year;
  final int studentMCount;
  final int startMToEndMCounter;
  final int month;
  final int amountPaid;
  final int currDue;
  final int pastDue;
  final int feeTillThisMonths; // 👈 now added here
  final Timestamp? paidAt;
  final String status; // "Paid" or "Unpaid"
  final Timestamp? createdAt;

  FeeMonth({
    required this.monthId,
    required this.year,
    required this.studentMCount,
    required this.startMToEndMCounter,
    required this.month,
    required this.amountPaid,
    required this.currDue,
    required this.pastDue,
    required this.feeTillThisMonths,
    this.paidAt,
    required this.status,
    this.createdAt,
  });

  /// Convert object -> Firestore
  Map<String, dynamic> toMap() {
    return {
      "monthId": monthId,
      "year": year,
      'studentMCount':studentMCount,
      'startMToEndMCounter':startMToEndMCounter,
      "month": month,
      "amountPaid": amountPaid,
      "currDue": currDue,
      "pastDue": pastDue,
      "feeTillThisMonths": feeTillThisMonths,
      "paidAt": paidAt,
      "status": status,
      "createdAt": createdAt ?? FieldValue.serverTimestamp(),
    };
  }

  /// Convert Firestore -> object
  factory FeeMonth.fromMap(Map<String, dynamic> map) {
    return FeeMonth(
      monthId: map["monthId"] ?? "",
      year: map["year"] ?? 0,
      studentMCount: map['studentMCount']??0,
      startMToEndMCounter: map['startMToEndMCounter']??0,
      month: map["month"] ?? 0,
      amountPaid: map["amountPaid"] ?? 0,
      currDue: map["currDue"] ?? 0,
      pastDue: map["pastDue"] ?? 0,
      feeTillThisMonths: map["feeTillThisMonths"] ?? 0,
      paidAt: map["paidAt"],
      status: map["status"] ?? "Unpaid",
      createdAt: map["createdAt"],
    );
  }
}

