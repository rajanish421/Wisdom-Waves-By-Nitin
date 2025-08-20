
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestServices{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchTest()async{
      try{

      }catch (e){
        print(e.toString());
      }
  }

}



