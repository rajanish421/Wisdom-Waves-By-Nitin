

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wisdom_waves_by_nitin/features/students/discussion/services/cloudinary_service.dart';

import '../../constant/app_colors.dart';
class ProfileUpdate{
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  ImagePicker _picker = ImagePicker();

  Future<void> updateProfilePic(String userId,BuildContext context,String cloudName ,String uploadPreset )async{
    try{
      CloudinaryServiceForChatting _cloudinary = CloudinaryServiceForChatting(cloudName: cloudName, uploadPreset: uploadPreset ,folder: "Profile Images");
      // Show a bottom sheet to let user choose Camera or Gallery
      final ImageSource? source = await showModalBottomSheet<ImageSource>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (_) => Container(
          padding: EdgeInsets.all(20),
          height: 230,
          child: Column(
            children: [
              Text("Select Image", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Camera option
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.camera_alt, size: 40,color: AppColors.appBarColor,),
                        onPressed: () => Navigator.pop(context, ImageSource.camera),
                      ),
                      Text("Camera")
                    ],
                  ),
                  // Gallery option
                  Column(
                    children: [
                      IconButton(
                        icon: Icon(Icons.photo, size: 40,color: AppColors.appBarColor),
                        onPressed: () => Navigator.pop(context, ImageSource.gallery),
                      ),
                      Text("Gallery")
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );

      if (source == null) return; // User canceled

      final xfile = await _picker.pickImage(source: source, imageQuality: 80);
      if (xfile == null) return;

      final url = await _cloudinary.uploadImage(File(xfile.path),);
      if (url == null) return;

      final res = await firestore.collection("students").doc(userId);

      res.update({
        'profile_url':url,
      });

    }catch(err){

    }
  }

}