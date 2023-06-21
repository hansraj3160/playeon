import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CustomVideoPlayer({required this.videoUrl});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = false;
  double _volume = 0.5;
  double _brightness = 0.5;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _playPause() {
    setState(() {
      if (_videoPlayerController.value.isPlaying) {
        _videoPlayerController.pause();
        _isPlaying = false;
      } else {
        _videoPlayerController.play();
        _isPlaying = true;
      }
    });
  }

  void _seekForward() {
    final Duration currentPosition = _videoPlayerController.value.position;
    final Duration seekPosition = currentPosition + Duration(seconds: 10);
    _videoPlayerController.seekTo(seekPosition);
  }

  void _seekBackward() {
    final Duration currentPosition = _videoPlayerController.value.position;
    final Duration seekPosition = currentPosition - Duration(seconds: 10);
    _videoPlayerController.seekTo(seekPosition);
  }

  void _changeVolume(double value) {
    setState(() {
      _volume = value;
      _videoPlayerController.setVolume(_volume);
    });
  }

  void _changeBrightness(double value) {
    setState(() {
      _brightness = value;
      // Apply brightness changes using platform-specific code or packages.
      // This example only updates the state variable.
    });
  }

  @override
  Widget build(BuildContext context) {

      return Scaffold(
        body: Stack(
          children: [
            AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            ),
            // Positioned(
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: AppBar(
            //     backgroundColor: Colors.transparent,
            //     elevation: 0,
            //   ),
            // ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Slider(
                    value: _volume,
                    onChanged: _changeVolume,
                  ),
                  Slider(
                    value: _brightness,
                    onChanged: _changeBrightness,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.fast_rewind),
                        onPressed: _seekBackward,
                      ),
                      IconButton(
                        icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                        onPressed: _playPause,
                      ),
                      IconButton(
                        icon: Icon(Icons.fast_forward),
                        onPressed: _seekForward,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    // } else {
    //   return CircularProgressIndicator();
    // }
  }
}
