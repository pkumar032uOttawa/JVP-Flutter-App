import 'package:flutter_vision/flutter_vision.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

Future<bool> checkPersonPresence(List<String> imagePaths) async {
  FlutterVision vision = FlutterVision();
  await loadYoloModel(vision);


  for (String path in imagePaths) {
    print("Checking Image: "+path+" For person");
    bool findPerson = await yoloOnImage(vision, path);
    print("Result from yoloOnImage: "+findPerson.toString());
    if(!findPerson){return false;}
  }

  await vision.closeYoloModel();
  return true;
}

Future<void> loadYoloModel(FlutterVision vision) async {
  await vision.loadYoloModel(
      labels: 'assets/labels.txt',
      modelPath: 'assets/yolov8n.tflite',
      modelVersion: "yolov8",
      quantization: false,
      numThreads: 2,
      useGpu: true);
}

Future<bool> yoloOnImage(FlutterVision vision, String imagePath) async {
  final byte = await File(imagePath).readAsBytes();
  final image = img.decodeImage(byte);
  final result = await vision.yoloOnImage(
      bytesList: byte,
      imageHeight: image!.height,
      imageWidth: image.width,
      iouThreshold: 0.8,
      confThreshold: 0.4,
      classThreshold: 0.5);
  if (result.isNotEmpty) {
    print("result: "+ result.toString());
    for (final x in result) {
      if (x['tag'] == 'person') {
        return true;
      }
    }
    return false;
  }
  return false;
}