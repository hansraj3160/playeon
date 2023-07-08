import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playeon/widgets/style.dart';
import 'package:video_player/video_player.dart';

import '../theme.dart';

class ChewieDemo extends StatefulWidget {
  String? url;

  ChewieDemo({Key? key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  ChewieController? _chewieController;
  double _volumeValue = 0.5;
  bool _isFullScreen = false;
  bool isshowbar = false;
  late VideoPlayerController _videoPlayerController2;

  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    _platform = TargetPlatform.android;
    // if (_isFullScreen) {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    // } else {
    //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    //       overlays: SystemUiOverlay.values);
    // }
    // if (Platform.isAndroid) {
    //   setState(() {
    //     _platform = TargetPlatform.android;
    //   });
    // } else if (Platform.isIOS) {
    //   setState(() {
    //     _platform = TargetPlatform.iOS;
    //   });
    // }

    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url!);

    _videoPlayerController2 = VideoPlayerController.network(widget.url!);
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize(),
    ]);
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    final subtitles = [
      Subtitle(
        index: 0,
        start: const Duration(seconds: 10),
        end: const Duration(seconds: 20),
        text: '',
      ),
      Subtitle(
        index: 0,
        start: const Duration(seconds: 10),
        end: const Duration(seconds: 20),
        text: '',
      ),
    ];

    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      zoomAndPan: true,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      fullScreenByDefault: true,
      showControls: true,
      autoInitialize: true,
      allowFullScreen: true,
      maxScale: 2.5,
      hideControlsTimer: const Duration(seconds: 4),
      controlsSafeAreaMinimum: EdgeInsets.all(0),
      subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(1.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.green,
        handleColor: Colors.green,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.white30,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
    );
  }

  void setVolume(double volume) {
    setState(() {
      _volumeValue = volume;
      _videoPlayerController1.setVolume(_volumeValue);
    });
  }

  void seekForward(Duration duration) {
    final currentPosition = _videoPlayerController1.value.position;
    final newPosition = currentPosition + duration;
    _videoPlayerController1.seekTo(newPosition);
  }

  void seekBackward(Duration duration) {
    final currentPosition = _videoPlayerController1.value.position;
    final newPosition = currentPosition - duration;
    _videoPlayerController1.seekTo(newPosition);
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light.copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        backgroundColor: primaryColorB,
        body: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? SafeArea(
                        child: Chewie(
                          controller: _chewieController!,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
