// import 'dart:io';
//

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:wisdom_waves_by_nitin/utills/show_animated_dialoge.dart';

import '../../../../Model/file_model.dart';
import '../services/download_services.dart';
import '../services/file_services.dart';
import '../services/storage_helper.dart';

class VideoLibraryScreen extends StatefulWidget {
  final String className;
  final String subject;

  VideoLibraryScreen({required this.className, required this.subject});

  @override
  _VideoLibraryScreenState createState() => _VideoLibraryScreenState();
}

class _VideoLibraryScreenState extends State<VideoLibraryScreen> {
  final FileService fileService = FileService();
  VideoPlayerController? _controller;
  ChewieController? _chewieController;

  Map<String, double> _downloadProgress = {}; // filename → 0.0 to 1.0
  String? _currentlyPlaying; // name of currently playing video
  String? _currentlySelected; // video paused but selected

  void _initializePlayer(String filePath, String videoName) async {
    // Pause previous
    await _controller?.pause();
    _chewieController?.dispose();
    _controller?.dispose();

    _controller = VideoPlayerController.file(File(filePath));
    await _controller!.initialize();

    _chewieController = ChewieController(
      videoPlayerController: _controller!,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      fullScreenByDefault: false,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ],
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    setState(() {
      _currentlyPlaying = videoName;
      _currentlySelected = videoName;
    });

    _controller?.addListener(() {
      if (_controller!.value.position >= _controller!.value.duration) {
        // Video ended
        setState(() {
          _currentlyPlaying = null;
          _currentlySelected = null;
        });
      }
    });

    setState(() {});
  }

  @override
  void dispose() {
    _controller?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("${widget.subject} Videos")),
      body: FutureBuilder<List<UploadModel>>(
        future: fileService.getVideos(widget.className, widget.subject),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final videos = snapshot.data!;

          return Column(
            children: [
              if (_chewieController != null &&
                  _controller != null &&
                  _controller!.value.isInitialized)
                Container(
                  height: 200,
                  child: Chewie(controller: _chewieController!),
                )
              else
                Container(
                  height: 200,
                  color: Colors.black12,
                  child: Center(child: Text("Download a video to play")),
                ),

              videos.length == 0
                  ? Text("No Video found")
                  : Expanded(
                    child: ListView.builder(
                      itemCount: videos.length,
                      itemBuilder: (context, index) {
                        final video = videos[index];
                        return FutureBuilder<bool>(
                          future: DownloadService.isFileDownloaded(video.name),
                          builder: (context, snap) {
                            final isDownloaded = snap.data ?? false;
                            final progress = _downloadProgress[video.name] ?? 0;
                            final isDownloading = progress > 0 && progress < 1;

                            final isPlaying = _currentlyPlaying == video.name;
                            final isPaused =
                                _currentlySelected == video.name && !isPlaying;

                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                color:
                                    (_currentlySelected == video.name)
                                        ? Colors.green.withOpacity(0.1)
                                        : Colors.white,
                                child: ListTile(
                                  title: Text(video.name),
                                  subtitle: Text(
                                    DateFormat(
                                      "yyyy/MM/dd HH:mm:ss",
                                    ).format(video.createdAt),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // 🎬 Play / Pause / Resume icon
                                      IconButton(
                                        icon: Icon(
                                          isPlaying
                                              ? Icons
                                                  .equalizer // playing
                                              : isPaused
                                              ? Icons
                                                  .play_arrow // paused
                                              : Icons.play_arrow, // not started
                                          color:
                                              (isDownloaded && !isDownloading)
                                                  ? Colors.green
                                                  : Colors.grey,
                                        ),
                                        onPressed:
                                            (isDownloaded && !isDownloading)
                                                ? () async {
                                                  final path =
                                                      await DownloadService.getLocalFilePath(
                                                        video.name,
                                                      );
                                                  if (path != null) {
                                                    if (_currentlySelected ==
                                                        video.name) {
                                                      // toggle pause/resume
                                                      if (_controller!
                                                          .value
                                                          .isPlaying) {
                                                        await _controller
                                                            ?.pause();
                                                      } else {
                                                        await _controller
                                                            ?.play();
                                                      }
                                                      setState(() {
                                                        _currentlyPlaying =
                                                            _controller!
                                                                    .value
                                                                    .isPlaying
                                                                ? video.name
                                                                : null;
                                                      });
                                                    } else {
                                                      // stop previous video
                                                      if (_currentlyPlaying !=
                                                          null)
                                                        await _controller
                                                            ?.pause();

                                                      _initializePlayer(
                                                        path,
                                                        video.name,
                                                      );
                                                    }
                                                  }
                                                }
                                                : null,
                                      ),

                                      // Download button
                                      if (!isDownloaded && !isDownloading)
                                        IconButton(
                                          icon: Icon(Icons.download),
                                          onPressed: () async {
                                            final path =
                                                await DownloadService.downloadFile(
                                                  video.url,
                                                  video.name,
                                                  (received, total) {
                                                    if (total != -1) {
                                                      setState(() {
                                                        _downloadProgress[video
                                                                .name] =
                                                            received / total;
                                                      });
                                                    }
                                                  },
                                                );

                                            if (path != null) {
                                              setState(() {
                                                _downloadProgress[video.name] =
                                                    0;
                                              });
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    "Downloaded: ${video.name}",
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),

                                      // Progress indicator
                                      if (isDownloading)
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircularProgressIndicator(
                                            value: progress,
                                          ),
                                        ),

                                      // Delete button
                                      if (isDownloaded && !isDownloading)
                                        IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: (){
                                             // await DownloadService.deleteFile(video.name);
                                            // setState(() {
                                            //   if (_currentlySelected ==
                                            //       video.name) {
                                            //     _currentlySelected = null;
                                            //     _currentlyPlaying = null;
                                            //   }
                                            // });
                                            AnimatedDialog.show(
                                              context,
                                              title: "Are you sure!",
                                              message: "Delete this downloaded video",
                                              primaryButtonAction: () async{
                                                await DownloadService.deleteFile(video.name);
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      "Deleted: ${video.name}",
                                                    ),
                                                  ),
                                                );
                                                setState(() {
                                                  if (_currentlySelected ==
                                                      video.name) {
                                                    _currentlySelected = null;
                                                    _currentlyPlaying = null;
                                                  }
                                                });
                                              },
                                              primaryButtonText: "Yes!",
                                              secondaryButtonText: "cancel",
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
            ],
          );
        },
      ),
    );
  }
}
