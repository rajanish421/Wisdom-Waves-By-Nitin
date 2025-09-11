import 'package:cloud_firestore/cloud_firestore.dart';
import'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Model/fee_model.dart';
// import 'package:flutter/material.dart';

class FeeServices {
  // create firestore instance
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // get fee data using userId

Future<FeeModel?> getFee(String userId)async{
   final res = await firestore.collection("fee").doc(userId).get();
   if(!res.exists){
     return null;
   }
   return FeeModel.fromMap(res.data()!);
}

}