// =======================
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';


class GenericViewer extends StatefulWidget {
  final String localPath; // local path to file
  final String type; // pdf,image,video


  const GenericViewer({super.key, required this.localPath, required this.type});


  @override
  State<GenericViewer> createState() => _GenericViewerState();
}


class _GenericViewerState extends State<GenericViewer> {
  VideoPlayerController? _controller;


  @override
  void initState() {
    super.initState();
    if (widget.type == 'videos') {
      _controller = VideoPlayerController.file(File(widget.localPath))
        ..initialize().then((_) {
          setState(() {});
          _controller!.play();
        });
    }
  }


  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Viewer')),
      body: Center(
        child: widget.type == 'pdf'
            ? SfPdfViewer.file(File(widget.localPath))
            : widget.type == 'images'
            ? Image.file(File(widget.localPath))
            : (_controller != null && _controller!.value.isInitialized)
            ? AspectRatio(aspectRatio: _controller!.value.aspectRatio, child: VideoPlayer(_controller!))
            : const CircularProgressIndicator(),
      ),
      floatingActionButton: widget.type == 'videos' && _controller != null
          ? FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller!.value.isPlaying ? _controller!.pause() : _controller!.play();
          });
        },
        child: Icon(_controller!.value.isPlaying ? Icons.pause : Icons.play_arrow),
      )
          : null,
    );
  }
}