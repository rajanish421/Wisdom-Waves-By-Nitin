// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:file_picker/file_picker.dart';
//
// import '../../../../Model/discussion_model.dart';
//
// Future<void> _sendImage(BuildContext context) async {
//   final ImagePicker _picker = ImagePicker();
//
//   // Show bottom sheet with options
//   final String? choice = await showModalBottomSheet<String>(
//     context: context,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (_) => Container(
//       padding: EdgeInsets.all(20),
//       height: 180,
//       child: Column(
//         children: [
//           Text("Select Source", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Column(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.camera_alt, size: 40),
//                     onPressed: () => Navigator.pop(context, 'camera'),
//                   ),
//                   Text("Camera")
//                 ],
//               ),
//               Column(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.photo, size: 40),
//                     onPressed: () => Navigator.pop(context, 'gallery'),
//                   ),
//                   Text("Gallery")
//                 ],
//               ),
//               Column(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.attach_file, size: 40),
//                     onPressed: () => Navigator.pop(context, 'file'),
//                   ),
//                   Text("File")
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
//
//   if (choice == null) return; // User canceled
//
//   File? selectedFile;
//
//   if (choice == 'camera') {
//     final XFile? xfile = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
//     if (xfile != null) selectedFile = File(xfile.path);
//   } else if (choice == 'gallery') {
//     final XFile? xfile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
//     if (xfile != null) selectedFile = File(xfile.path);
//   } else if (choice == 'file') {
//     FilePickerResult? result = await FilePicker.platform.pickFiles(
//       type: FileType.any,
//       allowMultiple: false,
//     );
//     if (result != null && result.files.single.path != null) {
//       selectedFile = File(result.files.single.path!);
//     }
//   }
//   //
//   if (selectedFile == null) return;
//
//   // Upload to Cloudinary
//   final url = await _cloudinary.uploadImage(selectedFile);
//   if (url == null) return;
//
//   // Send message
//   final msg = DiscussionMessage(
//     senderId: _uid,
//     senderName: _name,
//     imageUrl: url,
//     timestamp: DateTime.now(),
//   );
//
//   await _repo.sendMessage(msg);
//   _scrollToBottom();
// }
