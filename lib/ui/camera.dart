import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:jvp_app/model/shared_states.dart';
import 'package:jvp_app/utils/accelerometer.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:provider/provider.dart';

class CameraApp extends StatefulWidget {
  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  List<CameraDescription>? cameras;
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isRecording = false;
  bool isLoading = true; // Add a loading state indicator


  void initCameras() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras![0], // Use the first camera
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          isLoading = false; // Cameras are ready, stop showing loading indicator
        });
      }
    });
  }
  @override
  void initState() {
    super.initState();
    initCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take the Video')),
      extendBody: true,
      body: isLoading
          ? Center(child: CircularProgressIndicator())
      : Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Return the camera preview
                return Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CameraPreview(_controller),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              // Round button for recording
              child: FloatingActionButton.large(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                backgroundColor: Colors.white,
                onPressed: toggleRecording,
                child: Icon(isRecording ? Icons.stop : Icons.videocam, color: Colors.pink,),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, right: 30.0),
              // Button to switch cameras
              child: IconButton(
                icon: Icon(Icons.flip_camera_ios, size: 40, color: Colors.pink,),
                onPressed: switchCamera,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 40.0),
              // Exit button
              child: isRecording == true ? Accelerometer() : SizedBox()
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0, right: 30.0),
              // Exit button
              child: IconButton(
                icon: Icon(Icons.cancel, size: 40, color: Colors.pink,),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void toggleRecording() async {
    if (isRecording) {
      // Stop the video recording
      final XFile? video = await _controller.stopVideoRecording();
      if (mounted) {
        setState(() {
          isRecording = false;
        });
        // Pop and return the video file if recording was stopped successfully
        Navigator.pop(context, video);
      }
    } else {
      Provider.of<SharedState>(context, listen: false).isAccelerometerValid = true;
      await _initializeControllerFuture;
      // Start recording video
      _controller.startVideoRecording().then((_) {
        if (mounted) {
          setState(() {
            isRecording = true;
          });
        }
      });
    }
  }

  void switchCamera() async {
    // Get the index of the current camera
    final lensDirection = _controller.description.lensDirection;
    CameraDescription newCamera;
    if (lensDirection == CameraLensDirection.front) {
      newCamera = cameras!.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.back,
      );
    } else {
      newCamera = cameras!.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
      );
    }
    await _controller.dispose();
    // Initialize the controller with the new camera
    _controller = CameraController(
      newCamera,
      ResolutionPreset.max,
    );

    // If the controller is updated then update the UI.
    setState(() {
      _initializeControllerFuture = _controller.initialize();
    });
  }

  @override
  void dispose() {
    if(_controller != null) _controller.dispose();;
    super.dispose();
  }
}
