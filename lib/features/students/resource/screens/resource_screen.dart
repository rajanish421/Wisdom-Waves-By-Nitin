import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/image_preview_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/pdf_view_screen.dart';
import 'package:wisdom_waves_by_nitin/features/students/resource/screens/video_view_screen.dart';

import '../../../../Model/file_model.dart';


class ResourceScreen extends StatefulWidget {
  final String className;
  final String subjectName;

  const ResourceScreen({
    Key? key,
    required this.className,
    required this.subjectName,
  }) : super(key: key);


  @override
  State<ResourceScreen> createState() => _ResourceScreenState();
}


class _ResourceScreenState extends State<ResourceScreen> {
  String selectedType = 'videos'; // default tab selection

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.className}"),
      ),
      body: Column(
        children: [
// 🔹 Toggle buttons for PDF, Images, Videos
          Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTypeButton('pdf'),
                _buildTypeButton('images'),
                _buildTypeButton('videos'),
              ],
            ),
          ),
          const Divider(),
          Builder(
            builder: (context) {
              switch (selectedType) {
                case "videos":
                  return Expanded(child: VideoLibraryScreen(className: widget.className, subject: widget.subjectName));
                case "pdf":
                  return Expanded(child: PdfLibrary(subject: widget.subjectName,className: widget.className,));
                case "images":
                  return Expanded(child: ImagesScreen(className: widget.className, subject: widget.subjectName));
                default:
                  return const Text("Invalid selection");
              }
            },
          ),

        ],
      ),
    );
  }


  /// 🔹 Button Builder for PDF, Images, Videos
  Widget _buildTypeButton(String type) {
    bool isSelected = selectedType == type;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.blue : Colors.grey.shade300,
        foregroundColor: isSelected ? Colors.white : Colors.black,
      ),
      onPressed: () => setState(() => selectedType = type),
      child: Text(type.toUpperCase()),
    );
  }


  /// 🔹 Fetch and Display Video List from Firestore
  // Widget _buildVideoList() {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: FirebaseFirestore.instance
  //         .collection('files')
  //         .where('className', isEqualTo: widget.className)
  //         .where('subject', isEqualTo: widget.subject)
  //         .where('type', isEqualTo: 'videos')
  //         .orderBy('createdAt', descending: true)
  //         .snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const Center(child: CircularProgressIndicator());
  //       }
  //       if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
  //         return const Center(child: Text("No videos available."));
  //       }
  //
  //
  //       List<UploadModel> videos = snapshot.data!.docs
  //           .map((doc) => UploadModel.fromMap(doc.data() as Map<String, dynamic>))
  //           .toList();
  //
  //
  //       return ListView.builder(
  //         itemCount: videos.length,
  //         itemBuilder: (context, index) {
  //           final video = videos[index];
  //           return Card(
  //             margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(12),
  //             ),
  //             child: ListTile(
  //               leading: const Icon(Icons.play_circle_fill, color: Colors.blue, size: 36),
  //               title: Text(video.name),
  //               subtitle: Text("Uploaded: ${video.createdAt.toLocal().toString().split(' ')[0]}"),
  //               trailing: IconButton(
  //                 icon: const Icon(Icons.play_arrow, color: Colors.green),
  //                 onPressed: () {
  //                   // _openVideoPlayer(video.url, video.name);
  //                 },
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

}