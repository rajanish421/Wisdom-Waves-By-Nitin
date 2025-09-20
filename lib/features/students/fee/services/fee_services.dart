import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Model/fee_model.dart';
// import 'package:flutter/material.dart';

class FeeServices {
  // create firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  Future<FeeMonth> getCurrentMonthFee(String monthId,String userId)async{
    DocumentSnapshot<Map<String, dynamic>>  res = await firestore.collection("fee").doc(userId).collection("months").doc(monthId).get();
      return FeeMonth.fromMap(res.data()!);
  }

  // get fee data using userId

Future<FeeModel?> getFee(String userId)async{
   final res = await firestore.collection("fee").doc(userId).get();
   if(!res.exists){
     return null;
   }
   return FeeModel.fromMap(res.data()!);
}

}