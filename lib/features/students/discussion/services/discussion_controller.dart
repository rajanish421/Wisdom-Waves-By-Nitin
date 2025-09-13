import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Model/discussion_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'cloudinary_service.dart';
import 'discussion_repository.dart';

class DiscussionController with ChangeNotifier {
  final _repo = DiscussionRepository();
  final _cloudinary = CloudinaryService(
    cloudName: 'dosossycv',
    uploadPreset: 'wisdom_waves',
  );

  final textController = TextEditingController();
  final scrollController = ScrollController();
  final picker = ImagePicker();

  bool isSending = false;
  String uid = '';
  String name = 'Student';

  DiscussionController() {
    _initUser();
  }

  Stream<List<DiscussionMessage>> get messagesStream =>
      _repo.messagesStream(limit: 500);

  Future<void> _initUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      uid = user.uid;
      name = user.displayName ?? 'User-${user.uid.substring(0, 6)}';
    } else {
      final cred = await FirebaseAuth.instance.signInAnonymously();
      uid = cred.user!.uid;
      name = 'User-${uid.substring(0, 6)}';
    }
    notifyListeners();
  }

  Future<void> sendText() async {
    final text = textController.text.trim();
    if (text.isEmpty || isSending) return;
    isSending = true;

    final msg = DiscussionMessage(
      senderId: uid,
      senderName: name,
      text: text,
      timestamp: DateTime.now(),
    );
    await _repo.sendMessage(msg);
    textController.clear();
    _scrollToBottom();
    isSending = false;
    notifyListeners();
  }

  Future<void> sendImage() async {
    final xfile = await picker.pickImage(source: ImageSource.camera, imageQuality: 80);
    if (xfile == null) return;
    final url = await _cloudinary.uploadImage(File(xfile.path));
    if (url == null) return;

    final msg = DiscussionMessage(
      senderId: uid,
      senderName: name,
      imageUrl: url,
      timestamp: DateTime.now(),
    );
    await _repo.sendMessage(msg);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  void disposeController() {
    textController.dispose();
    scrollController.dispose();
  }
}
