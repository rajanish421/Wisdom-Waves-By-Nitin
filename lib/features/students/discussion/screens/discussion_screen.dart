import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wisdom_waves_by_nitin/Model/students_model.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
import 'package:wisdom_waves_by_nitin/utills/show_animated_dialoge.dart';
import '../../../../Model/discussion_model.dart';
import '../services/cloudinary_service.dart';
import '../services/discussion_repository.dart';
import '../widgets/message_tile.dart';
import 'package:file_picker/file_picker.dart';

class DiscussionScreen extends StatefulWidget {
  final Students student;

  const DiscussionScreen({super.key, required this.student});

  @override
  State<DiscussionScreen> createState() => _DiscussionScreenState();
}

class _DiscussionScreenState extends State<DiscussionScreen> {
  // bool isSending = false;

  final _repo = DiscussionRepository();
  final _cloudinary = CloudinaryServiceForChatting(
    cloudName: dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? "",
    uploadPreset: dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? "",
  );

  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _picker = ImagePicker();

  // final _recorder = AudioRecorder();
  // final _audioPlayer = AudioPlayer();

  bool _isSending = false;

  // bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    // _initUser();
  }

  Future<void> _sendText() async {
    final text = _textController.text.trim();
    if (text.isEmpty || _isSending) return;
    setState(() {
      _isSending = true;
    });

    final String id = DateTime.now().microsecondsSinceEpoch.toString();
    final msg = DiscussionMessage(
      id: id,
      senderId: widget.student.userId,
      senderName: widget.student.name,
      text: text,
      timestamp: DateTime.now(),
    );
    await _repo.sendMessage(msg, id);
    _textController.clear();
    _saveLastOpenedAt();
    // _scrollToBottom();
    setState(() {
      _isSending = false;
    });
  }

  /// ✅ Save timestamp when chat opened
  Future<void> _saveLastOpenedAt() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("lastOpenedAt", DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _sendImage() async {
    // final ImagePicker _picker = ImagePicker();

    // Show a bottom sheet to let user choose Camera or Gallery
    final ImageSource? source = await showModalBottomSheet<ImageSource>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (_) => Container(
            padding: EdgeInsets.all(20),
            height: 230,
            child: Column(
              children: [
                Text(
                  "Select Image",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Camera option
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            size: 40,
                            color: AppColors.appBarColor,
                          ),
                          onPressed:
                              () => Navigator.pop(context, ImageSource.camera),
                        ),
                        Text("Camera"),
                      ],
                    ),
                    // Gallery option
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.photo,
                            size: 40,
                            color: AppColors.appBarColor,
                          ),
                          onPressed:
                              () => Navigator.pop(context, ImageSource.gallery),
                        ),
                        Text("Gallery"),
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
    // Loading
    setState(() {
      _isSending = true;
    });

    final url = await _cloudinary.uploadImage(File(xfile.path));
    if (url == null) return;
    final String id = DateTime.now().microsecondsSinceEpoch.toString();
    final msg = DiscussionMessage(
      id: id,
      senderId: widget.student.userId,
      senderName: widget.student.name,
      imageUrl: url,
      timestamp: DateTime.now(),
    );

    await _repo.sendMessage(msg, id);
    //    this is for update last message time.
    setState(() {
      _isSending = false;
    });
    _saveLastOpenedAt();

    // _scrollToBottom();
  }

  // void _scrollToBottom() {
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     if (_scrollController.hasClients) {
  //       _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  //     }
  //   });
  // }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    // _audioPlayer.dispose();
    // _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Community Discussion')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<List<DiscussionMessage>>(
                stream: _repo.messagesStream(limit: 500),
                builder: (context, snap) {
                  if (!snap.hasData)
                    return const Center(child: CircularProgressIndicator());
                  final messages = snap.data!;
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   if (_scrollController.hasClients) {
                  //     _scrollController.jumpTo(
                  //       _scrollController.position.maxScrollExtent,
                  //     );
                  //   }
                  // });
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: messages.length,
                    reverse: true,
                    itemBuilder: (_, i) {
                      final m = messages[messages.length - 1 - i];
                      final isMe = m.senderId == widget.student.userId;
                      return InkWell(
                        onLongPress:
                            isMe == true
                                ? () {
                                  // print(m.senderId);
                                  AnimatedDialog.show(
                                    context,
                                    title: "Are you sure!",
                                    message:
                                        "Do you want to delete this message",
                                    primaryButtonText: "Delete",
                                    secondaryButtonText: "Cancel",
                                    primaryButtonAction: () {
                                      if(m.imageUrl != null){
                                        _repo.deleteImageFromFirestoreAndCloudinary(docId: m.id.toString(), imageUrl: m.imageUrl.toString());
                                      }else if (m.text != null){
                                        _repo.deleteMessage(m.id.toString());
                                      }
                                    },
                                  );
                                }
                                : null,
                        child: MessageTile(message: m, isMe: isMe, index: i),
                      );
                    },
                  );
                },
              ),
            ),
            SafeArea(
              top: false,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image, color: AppColors.appBarColor),
                    onPressed: _sendImage,
                  ),
                  // IconButton(
                  //   icon: Icon(_isRecording ? Icons.mic_off : Icons.mic,
                  //       color: _isRecording ? Colors.red : Colors.deepPurple),
                  //   onPressed: _toggleRecording,
                  // ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextField(
                        controller: _textController,
                        minLines: 1,
                        maxLines: 5,
                        onSubmitted: (_) => _sendText(),
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  _isSending == true
                      ? CircularProgressIndicator(
                        constraints: BoxConstraints.tight(Size.square(25)),
                      )
                      : IconButton(
                        icon: Icon(Icons.send, color: AppColors.appBarColor),
                        onPressed: _sendText,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
