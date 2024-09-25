import 'dart:io';
import 'package:flutter/material.dart';
import 'package:jvp_app/provider/shared_states.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_frame_extractor/video_frame_extractor.dart';
import 'package:jvp_app/utils/illumination_check.dart';
import 'package:jvp_app/ui/video_check_result.dart';
import 'package:jvp_app/pages/questionnaire.dart';
import 'package:jvp_app/utils/yolo_detection.dart';
import 'package:provider/provider.dart';

class VideoCheckPage extends StatefulWidget {
  final String videoPath;
  final double skinBrightness;

  VideoCheckPage({required this.videoPath, required this.skinBrightness});

  @override
  _VideoCheckPageState createState() => _VideoCheckPageState();
}

class _VideoCheckPageState extends State<VideoCheckPage> {
  late VideoPlayerController _controller;
  bool? _isDurationValid;
  bool? _isAccelerometerValid;
  bool? _presencePerson;
  int? illuStatus;
  bool _isLengthCheckingLoading = true;
  bool _isIlluCheckingLoading = true;// Flag to track if we are still loading the video


  @override
  void initState() {
    super.initState();
    initializeVideoPlayer();
    _checkIlluFace(widget.skinBrightness);
  }

  Future<void> initializeVideoPlayer() async {
    _controller = VideoPlayerController.file(File(widget.videoPath));
    await _controller.initialize();
    if (!mounted) return;
    final videoLength = _controller.value.duration.inSeconds;
    setState(() {
      _isDurationValid = videoLength >= 15 && videoLength <= 30;
      _isLengthCheckingLoading = false;
    });
    _controller.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now it's safe to access the provider
    _isAccelerometerValid = Provider.of<SharedState>(context, listen: false).isAccelerometerValid;
  }

  Future<void> _checkIlluFace(double skinBrightness) async {
    String tempPath = (await getTemporaryDirectory()).path;
    print("Temp path is: " + tempPath);

    // frames is the list of locations
    List<String> frames = await VideoFrameExtractor.fromFile(
        video: File(widget.videoPath),
        destinationDirectoryPath: tempPath,
        imagesCount: 3
    );

    // Check illumination
    int result = await checkIlluminationValues(frames, skinBrightness);
    // Check the presence of human
    bool presencePerson = await checkPersonPresence(frames);


    // deletePngFiles(tempPath);
    setState(() {
      illuStatus = result;
      _presencePerson = presencePerson;
      _isIlluCheckingLoading = false;
    });
  }

  @override
  void dispose() {
    if(_controller!= null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Check'),
      ),
      body: Center(
        child: _isIlluCheckingLoading || _isLengthCheckingLoading
            ? CircularProgressIndicator() // Show loading indicator while video is loading
            :
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           /* if (_isDurationValid != null && illuStatus != null && _presencePerson != null && _isAccelerometerValid != null)
              if (_isDurationValid! && illuStatus == 2 && _isAccelerometerValid! && _presencePerson!)*/
                Column(
                  children: [
                    Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
                    SizedBox(height: 30,),
                    Text(
                        'Congratulations, you have met all requirements!',
                        style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.w800),
                        textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to VideoCheckPage when the button is pressed
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HeartCareScreening(videoPath: widget.videoPath),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor : Colors.teal, // Button color
                        foregroundColor : Colors.white, // Text color
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: Text(
                        'Answer Questions Before Uploading',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                )
              /*else
                Column(
                  children: [
                    RequirementCard(
                        requirementMet: _isDurationValid!,
                        explanation: _isDurationValid! ? "Good video length! Exactly between 15s and 30s" : "Wrong video length! Should be between 15s and 30s"
                    ),
                    RequirementCard(
                        requirementMet: _isAccelerometerValid!,
                        explanation: _isAccelerometerValid! ? "The video is stable. Good job!" : "The video is shaking. Please stabilize it"
                    ),
                    RequirementCard(
                        requirementMet: illuStatus==2,
                        explanation: getIlluminationText(illuStatus)
                    ),
                    RequirementCard(
                        requirementMet: _presencePerson!,
                        explanation: _presencePerson! ? "Can consistently see you in camera!" : "Cant consistently see you, make sure you are always in camera!"
                    ),
                  ],
                ),*/
          ],
        ),
      ),
    );
  }
  String getIlluminationText(illuStatus){
    if(illuStatus==0) return "The environment is too dark! Try again";
    else if(illuStatus==1) return "The lighting is not consistent! Try again";
    else if(illuStatus==2) return "Perfect Lighting!";
    else return "Wrong value received";
  }
}