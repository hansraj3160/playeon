import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:playeon/widgets/style.dart';
import 'package:video_player/video_player.dart';

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
  @override
  void initState() {
    super.initState();
    _platform = TargetPlatform.iOS;
    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
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
    _chewieController?.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url!);
    await Future.wait([
      _videoPlayerController1.initialize(),
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
      aspectRatio: 1,
      fullScreenByDefault: true,
      showControls: true,
      autoInitialize: true,
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
      home: Scaffold(
        backgroundColor: primaryColorB,
        body: Center(
          child: RotatedBox(
            quarterTurns: 1,
            child: Stack(
              children: <Widget>[
                Center(
                  child: _chewieController != null &&
                          _chewieController!
                              .videoPlayerController.value.isInitialized
                      ? _isFullScreen
                          ? Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Chewie(
                                    controller: _chewieController!,
                                  ),
                                ),
                              ],
                            )
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  isshowbar = !isshowbar;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Chewie(
                                      controller: _chewieController!,
                                    ),
                                  ),
                                ],
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: isshowbar
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.replay_10,
                                  color: primaryColorW,
                                ),
                                onPressed: () {
                                  seekBackward(Duration(seconds: 10));
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.forward_10,
                                  color: primaryColorW,
                                ),
                                onPressed: () {
                                  seekForward(Duration(seconds: 10));
                                },
                              ),
                            ],
                          ),
                        )
                      : null,
                ),
                SizedBox(
                    child: isshowbar
                        ? Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  width: 10,
                                  child: RotatedBox(
                                    quarterTurns: 3,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.volume_up,
                                            color: primaryColor1, size: 15),
                                        SliderTheme(
                                          data: const SliderThemeData(
                                            activeTrackColor: primaryColor1,
                                            thumbColor: primaryColor1,
                                            overlayShape:
                                                RoundSliderOverlayShape(
                                                    overlayRadius: 5.0),
                                            tickMarkShape:
                                                RoundSliderTickMarkShape(
                                                    tickMarkRadius: 1.0),
                                            thumbShape: RoundSliderThumbShape(
                                              enabledThumbRadius: 4.0,
                                            ),
                                          ),
                                          child: Slider(
                                            value: _volumeValue,
                                            min: 0.0,
                                            max: 1.0,
                                            onChanged: (value) {
                                              setVolume(value);
                                            },
                                            label: "Volume",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          )
                        : null),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
