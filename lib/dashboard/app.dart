import 'dart:io';

import 'package:chewie/chewie.dart';

import 'package:flutter/material.dart';
import 'package:playeon/widgets/style.dart';
// ignore: depend_on_referenced_packages
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
  late VideoPlayerController _videoPlayerController2;
  ChewieController? _chewieController;
  int? bufferDelay;

  @override
  void initState() {
    _chewieController?.enterFullScreen();
    super.initState();
    if (Platform.isAndroid) {
      setState(() {
        _platform = TargetPlatform.android;
        _chewieController?.enterFullScreen();
      });
    } else if (Platform.isIOS) {
      setState(() {
        _platform = TargetPlatform.iOS;
      });
    }

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
      _videoPlayerController2.initialize()
    ]);
    _createChewieController();
    setState(() {
      _chewieController?.enterFullScreen();
    });
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
      fullScreenByDefault: true,
      showControls: true,
      autoInitialize: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      additionalOptions: (context) {
        return <OptionItem>[];
      },
      subtitle: Subtitles(subtitles),
      subtitleBuilder: (context, dynamic subtitle) => Container(
        padding: const EdgeInsets.all(10.0),
        child: subtitle is InlineSpan
            ? RichText(
                text: subtitle,
              )
            : Text(
                subtitle.toString(),
                style: const TextStyle(color: Colors.black),
              ),
      ),
      hideControlsTimer: const Duration(seconds: 5),
      maxScale: 1,
      draggableProgressBar: true,
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

  Future<void> toggleVideo() async {
    await _videoPlayerController1.pause();

    await initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light.copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        backgroundColor: primaryColorB,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(
                child: _chewieController != null &&
                        _chewieController!
                            .videoPlayerController.value.isInitialized
                    ? Chewie(
                        controller: _chewieController!,
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            color: primaryColor1,
                          ),
                          SizedBox(height: 20),
                          Text('Loading'),
                        ],
                      ),
              ),
              // TextButton(
              //   onPressed: () {
              //     _chewieController?.optionsTranslation;
              //   },
              //   child: const Text('Fullscreen'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
