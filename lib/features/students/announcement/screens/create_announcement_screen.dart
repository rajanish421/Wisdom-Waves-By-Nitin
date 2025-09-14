// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import '../../../models/announcement_model.dart';
// import '../services/announcement_service.dart';
// import '../services/cdn_services.dart';
//
// class CreateAnnouncementScreen extends StatefulWidget {
//   @override
//   _CreateAnnouncementScreenState createState() =>
//       _CreateAnnouncementScreenState();
// }
//
// class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _titleController = TextEditingController();
//   final _messageController = TextEditingController();
//
//   final _service = AnnouncementService();
//   final _cloudinary = CdnService(
//     cloudName: "dosossycv", // 👈 apna cloudName daalo
//     uploadPreset: "wisdom_waves", // 👈 apna preset daalo
//   );
//
//   File? _selectedImage;
//   bool _isLoading = false;
//
//   Future<void> _pickImage() async {
//     print("pick call");
//     try{
//       final picker = ImagePicker();
//       final pickedFile = await picker.pickImage(source: ImageSource.camera);
//
//       if (pickedFile != null) {
//         setState(() => _selectedImage = File(pickedFile.path));
//       }
//     }catch(err){
//       print(err.toString());
//     }
//   }
//
//   Future<void> _saveAnnouncement() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() => _isLoading = true);
//
//     String? imageUrl;
//     if (_selectedImage != null) {
//       imageUrl = await _cloudinary.uploadImage(_selectedImage!);
//     }
//
//     final announcement = Announcement(
//       announcementId: '', // will be set in service
//       title: _titleController.text.trim(),
//       message: _messageController.text.trim(),
//       imageUrl: imageUrl,
//       createdAt: DateTime.now(),
//     );
//
//     await _service.addAnnouncement(announcement);
//
//     setState(() => _isLoading = false);
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Create Announcement")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               TextFormField(
//                 controller: _titleController,
//                 decoration: const InputDecoration(labelText: "Title"),
//                 validator: (value) => value!.isEmpty ? "Enter title" : null,
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 controller: _messageController,
//                 maxLines: 3,
//                 decoration: const InputDecoration(labelText: "Message"),
//                 validator: (value) => value!.isEmpty ? "Enter message" : null,
//               ),
//               const SizedBox(height: 16),
//               _selectedImage != null
//                   ? Image.file(_selectedImage!, height: 150, fit: BoxFit.cover)
//                   : const Text("No image selected"),
//               const SizedBox(height: 10),
//               OutlinedButton.icon(
//                 onPressed: (){
//                   _pickImage();
//                 },
//                 icon: const Icon(Icons.image),
//                 label: const Text("Pick Image"),
//               ),
//               const SizedBox(height: 20),
//               _isLoading
//                   ? const CircularProgressIndicator()
//                   : ElevatedButton(
//                 onPressed: _saveAnnouncement,
//                 child: const Text("Save"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
