

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wisdom_waves_by_nitin/Model/students_model.dart';
import 'package:wisdom_waves_by_nitin/comman/widgets/show_snack_bar.dart';
import 'package:wisdom_waves_by_nitin/utills/show_message_dialogue.dart';

import '../../students_bottom_nav_bar.dart';

class AuthServices{
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    String studentsCollection = "students";
  // login

Future<void> login(String user , String password,BuildContext context)async{
  String userId = "${user}@gmail.com";
  try{
    // user login
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: userId, password: password);
    // print("-----------------------------------------........... Login succees");
    // get user Data
    final student = await getStudentData(user);

    // check exist or not
    if(student == null){
        showMessageDialog(context: context, title: "Login failed", message: "Please meet admin",isSuccess: false);
        return;
    }
    // all success
    // showMessageDialog(context: context, title: "Logged in", message: "Welcome to Wisdom Waves By Nitin");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StudentsBottomNavBar(),));

  }on FirebaseAuthException catch(e){
    // Firebase Auth errors
    // print("-----------------------------------------${e.toString()}");
    String errorMessage;
    switch (e.code) {
      case 'user-not-found':
        errorMessage = 'No user found with this UserID.';
        break;
      case 'wrong-password':
        errorMessage = 'Incorrect password.';
        break;
      case 'invalid-email':
        errorMessage = 'Invalid email format.';
        break;
      case 'user-disabled':
        errorMessage = 'This account has been disabled.';
        break;
      case 'invalid-credential':
        errorMessage = 'The UserID or Password you entered is incorrect';
        break;
      case 'email-already-in-use':
        errorMessage = 'An account already exists with this UserID.';
        break;
      case 'weak-password':
        errorMessage = 'Password is too weak.';
        break;
      case 'operation-not-allowed':
        errorMessage = 'This sign-in method is not enabled.';
        break;
      case 'account-exists-with-different-credential':
        errorMessage = 'Account exists with a different sign-in method.';
        break;
      case 'network-request-failed':
        errorMessage = 'Network issue. Please check your connection.';
        break;
      case 'too-many-requests':
        errorMessage = 'Too many attempts. Try again later.';
        break;
      default:
        errorMessage = 'Please try again.';
    }
    // show error
    showMessageDialog(context: context, title: "Login Failed", message: errorMessage,isSuccess: false);

  }on FirebaseException catch(e){
    // print("5555555555555555555555555555555555555555555555555-------------------------->${e.toString()}");
    // Firestore-specific errors
    String errorMessage;
    if (e.plugin == 'cloud_firestore') {
      if (e.code == 'permission-denied') {
        errorMessage = 'You do not have permission to access this data.';
      } else if (e.code == 'unavailable') {
        errorMessage = 'Firestore service is temporarily unavailable.';
      } else if (e.code == 'not-found') {
        errorMessage = 'Student record not found in database.';
      } else {
        errorMessage = 'Database error: ${e.message}';
      }
    } else {
      errorMessage = 'Unexpected Firebase error: ${e.message}';
    }

    // show error
    showMessageDialog(context: context, title: "Login Failed", message: errorMessage,isSuccess: false);

  }
}

// get student data

  Future<Students?> getStudentData(String userId)async{
    try{
      final doc = await _firestore.collection(studentsCollection).doc(userId).get();
      // check student exist before return
      if (!doc.exists) return null;
      return Students.fromMap(doc.data()!);
    }on FirebaseException catch(e){
      // print("33333333333333333333333333333333333333333333333333333333333------>${e.code}");
      rethrow;
    }catch (e){
      // print("33333333333333333333333333333333333333333333333333333333333------>${e.toString()}");

      rethrow;
    }
  }

}