import 'dart:async';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:playeon/widgets/style.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

class DefaultPlayer extends StatefulWidget {
  String? url;
  DefaultPlayer({Key? key, this.url}) : super(key: key);

  @override
  _DefaultPlayerState createState() => _DefaultPlayerState();
}

class _DefaultPlayerState extends State<DefaultPlayer> {
  late FlickManager flickManager;
  late VideoPlayerController videoPlayerController;
  int currentTime = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url!);
    flickManager = FlickManager(videoPlayerController: videoPlayerController);
    startTimer();
  }

  @override
  void dispose() {
    flickManager.dispose();
    videoPlayerController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        currentTime++;
      });
    });
  }

  void moveForward() {
    setState(() {
      currentTime += 10;
      videoPlayerController.seekTo(Duration(seconds: currentTime));
    });
  }

  void moveBackward() {
    setState(() {
      currentTime -= 10;
      videoPlayerController.seekTo(Duration(seconds: currentTime));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorB,
      body: VisibilityDetector(
        key: ObjectKey(flickManager),
        onVisibilityChanged: (visibility) {
          if (visibility.visibleFraction == 0 && this.mounted) {
            flickManager.flickControlManager?.autoPause();
          } else if (visibility.visibleFraction == 1) {
            flickManager.flickControlManager?.autoResume();
          }
        },
        child: Stack(
          children: [
            FlickVideoPlayer(
              flickManager: flickManager,
              flickVideoWithControls: const FlickVideoWithControls(
                closedCaptionTextStyle: TextStyle(fontSize: 8),
                controls: FlickPortraitControls(),
              ),
              flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                controls: FlickLandscapeControls(),
              ),
            ),
            // Align(
            //   alignment: Alignment.center,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       InkWell(
            //         onTap: moveBackward,
            //         child: Icon(
            //           Icons.replay_10,
            //           color: primaryColor1,
            //         ),
            //       ),
            //       SizedBox(width: 100),
            //       InkWell(
            //         onTap: moveForward,
            //         child: Icon(
            //           Icons.forward_10,
            //           color: primaryColor1,
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
