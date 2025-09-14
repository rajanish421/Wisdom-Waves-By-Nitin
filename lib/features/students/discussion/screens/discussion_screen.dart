import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:wisdom_waves_by_nitin/Model/students_model.dart';
import 'package:wisdom_waves_by_nitin/constant/app_colors.dart';
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
  final _repo = DiscussionRepository();
  final _cloudinary = CloudinaryServiceForChatting(
    cloudName: 'dosossycv',
    uploadPreset: 'wisdom_waves',
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
    _isSending = true;
    final String id = DateTime.now().microsecondsSinceEpoch.toString();
    final msg = DiscussionMessage(
      id: id,
      senderId: widget.student.userId,
      senderName: widget.student.name,
      text: text,
      timestamp: DateTime.now(),
    );
    await _repo.sendMessage(msg,id);
    _textController.clear();
    _scrollToBottom();
    _isSending = false;
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

    await _repo.sendMessage(msg,id);
    _scrollToBottom();
  }

  // Future<void> _toggleRecording() async {
  //   if (_isRecording) {
  //     final path = await _recorder.stop();
  //     setState(() => _isRecording = false);
  //     if (path == null) return;
  //
  //     final url = await _cloudinary.uploadAudio(File(path));
  //     if (url == null) return;
  //
  //     final msg = DiscussionMessage(
  //       senderId: _uid,
  //       senderName: _name,
  //       audioUrl: url,
  //       timestamp: DateTime.now(),
  //     );
  //     await _repo.sendMessage(msg);
  //     _scrollToBottom();
  //   } else {
  //     if (!await _recorder.hasPermission()) return;
  //     await _recorder.start(const RecordConfig(), path: 'voice_${DateTime.now().millisecondsSinceEpoch}.m4a');
  //     setState(() => _isRecording = true);
  //   }
  // }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<DiscussionMessage>>(
              stream: _repo.messagesStream(limit: 500),
              builder: (context, snap) {
                if (!snap.hasData)
                  return const Center(child: CircularProgressIndicator());
                final messages = snap.data!;
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  itemBuilder: (_, i) {
                    final m = messages[i];
                    final isMe = m.senderId == widget.student.userId;
                    return InkWell(
                      onLongPress: isMe == true ? () {
                        // print(m.senderId);
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                actionsAlignment: MainAxisAlignment.spaceBetween,
                                alignment: Alignment.center,
                                title: Text("Delete"),
                                actions: [
                                  TextButton(onPressed:(){
                                    if(m.imageUrl != null){
                                      _repo.deleteImageFromFirestoreAndCloudinary(docId: m.id.toString(), imageUrl: m.imageUrl.toString());
                                    }else if (m.text != null){
                                      _repo.deleteMessage(m.id.toString());
                                    }
                                    Navigator.pop(context);
                                  }, child: Text("delete")),
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("cancel")),

                                ],
                              ),
                        );
                      }:null,
                      child: MessageTile(message: m, isMe: isMe),
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
                  icon: const Icon(Icons.image),
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
                IconButton(icon: const Icon(Icons.send), onPressed: _sendText),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
