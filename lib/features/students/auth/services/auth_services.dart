

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/comman/widgets/show_snack_bar.dart';

import '../../students_bottom_nav_bar.dart';

class AuthServices{
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // login

Future<void> login(String userId , String password,BuildContext context)async{
  try{
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: userId, password: password);
    showCustomSnackBar(text: "Successfull", context: context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => StudentsBottomNavBar(),));
  }on FirebaseAuthException catch(e){
    print(e.toString());
    showCustomSnackBar(text: e.toString(), context: context);
      }
}


}