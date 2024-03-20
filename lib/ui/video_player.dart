import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoLocation;
  final bool isAsset;

  const VideoPlayerWidget({Key? key, required this.videoLocation, this.isAsset = true}) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController; // Made nullable to handle initState lifecycle

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  Future<void> initializePlayer() async {
    // Initialize the controller with the videoLocation provided by the widget
    _videoPlayerController = widget.isAsset
        ? VideoPlayerController.asset(widget.videoLocation)
        : VideoPlayerController.file(File(widget.videoLocation));

    await _videoPlayerController.initialize(); // Ensure controller is initialized before creating ChewieController
    print("?????????????? in good case"+widget.videoLocation);
    print("????????????? in good case"+mounted.toString());
    if (!mounted) return; // Check if the widget is still in the tree

    print("?????????????? in good case"+_videoPlayerController.value.duration.inSeconds.toString());
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: _videoPlayerController.value.aspectRatio,
      autoPlay: false,
      looping: false,
      // Customize other parameters according to your needs
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.lightBlueAccent,
        handleColor: Colors.red,
        backgroundColor: Colors.white,
        bufferedColor: Colors.grey,
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      autoInitialize: true,
    );

    setState(() {}); // Refresh the state to update UI when the video is ready
  }

  @override
  void dispose() {
    print("!!!!!!! disposing video player"+widget.videoLocation);
    _videoPlayerController.dispose();
    _chewieController?.dispose(); // Use null-aware call since _chewieController is nullable
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        if (_videoPlayerController.value.isInitialized && _chewieController != null)
          AspectRatio(
            aspectRatio: _chewieController!.aspectRatio!,
            child: Chewie(
              controller: _chewieController!,
            ),
          )
        else
          Container(
            height: 400,
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
