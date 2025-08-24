import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final String videoUrl;

  const VideoCard({super.key, required this.videoUrl});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // refresh when video is ready
      });
    _controller.play();
    // _controller.setVolume(0);
    // _changeVolume(0);
    setState(() {
      _controller.setVolume(0);
      _isMuted = true;
    });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      if (_isMuted) {
        _controller.setVolume(_volume); // restore volume
        _isMuted = false;
      } else {
        _controller.setVolume(0);
        _isMuted = true;
      }
    });
  }

  void _changeVolume(double value) {
    setState(() {
      _volume = value;
      _controller.setVolume(value);
      _isMuted = value == 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAlias,
      child: _controller.value.isInitialized
          ? Stack(
        alignment: Alignment.center,
        children: [
          // Video fills the card
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller.value.size.width,
                height: _controller.value.size.height,
                child: VideoPlayer(_controller),
              ),
            ),
          ),

          // Center Play/Pause button
          Positioned.fill(
            child: GestureDetector(
              onTap: _togglePlayPause,
              child: AnimatedOpacity(
                opacity: _controller.value.isPlaying ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  color: Colors.black38,
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom controls (mute + volume)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                    ),
                    onPressed: _toggleMute,
                  ),
                  Expanded(
                    child: Slider(
                      value: _volume,
                      min: 0,
                      max: 1,
                      divisions: 10,
                      activeColor: Colors.white,
                      inactiveColor: Colors.grey,
                      onChanged: _changeVolume,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
          : const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
