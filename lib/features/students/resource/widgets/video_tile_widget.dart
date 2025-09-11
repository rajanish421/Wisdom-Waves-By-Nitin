// import 'dart:io';
// import 'package:flutter/material.dart';
// import '../models/upload_model.dart';
// import '../services/download_service.dart';
//
//
// class VideoTile extends StatefulWidget {
//   final UploadModel model;
//   final VoidCallback onPlayLocal; // called when local play should start
//
//
//   const VideoTile({super.key, required this.model, required this.onPlayLocal});
//
//
//   @override
//   State<VideoTile> createState() => _VideoTileState();
// }
//
//
// class _VideoTileState extends State<VideoTile> {
//   final DownloadService _downloadService = DownloadService();
//   bool _isDownloading = false;
//   double _progress = 0;
//   String? _localPath;
//
//
//   @override
//   void initState() {
//     super.initState();
//     _checkDownloaded();
//   }
//
//
//   Future<void> _checkDownloaded() async {
//     final exists = await _downloadService.isDownloaded(
//         widget.model.className, widget.model.subject, widget.model.name);
//     if (exists) {
//       final p = await _downloadService
//           ._filePathFor(widget.model.className, widget.model.subject, widget.model.name);
//       setState(() => _localPath = p);
//     }
//   }
//
//
//   Future<void> _startDownload() async {
//     setState(() {
//       _isDownloading = true;
//       _progress = 0;
//     });
//
//
//     final local = await _downloadService.downloadFile(
//       url: widget.model.url,
//       className: widget.model.className,
//       subject: widget.model.subject,
//       fileName: widget.model.name,
//       onProgress: (received, total) {
//         if (total != -1) {
//           setState(() {
//             _progress = received / total;
//           });
//         }
//       },
//     );
//
//
//   }