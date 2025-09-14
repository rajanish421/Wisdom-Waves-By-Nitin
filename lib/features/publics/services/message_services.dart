

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdom_waves_by_nitin/Custom_Widget/toast_message.dart';
import 'package:wisdom_waves_by_nitin/Model/feedback_model.dart';
import 'package:flutter/material.dart';
class MessageServices{
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> sendMessage(String name , String message , BuildContext context)async{
    try{
      final ref = firebaseFirestore.collection("FeedbackMessage").doc();
      final messageModel = FeedbackModel(id: ref.id, name: name, message: message, createdAt: DateTime.now());
      await ref.set(messageModel.toMap());
      ToastMessage.show(message: "Feedback submitted successfully ✅");
    }catch(err){
      ToastMessage.show(message: "Error ${err.toString()}",backgroundColor: Colors.red);
    }
  }

}