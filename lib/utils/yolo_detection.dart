import 'package:flutter_vision/flutter_vision.dart';
import 'dart:io';
import 'package:image/image.dart' as img;

Future<bool> checkPersonPresence(List<String> imagePaths) async {
  FlutterVision vision = FlutterVision();
  await loadYoloModel(vision);


  for (String path in imagePaths) {
    bool findPerson = await yoloOnImage(vision, path);
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Here you can turn off human detection by comment the line below: if(!findPerson){return false;}
    // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    if(!findPerson){return false;}
  }

  await vision.closeYoloModel();
  return true;
}

Future<void> loadYoloModel(FlutterVision vision) async {
  print("loading yolov8");
  await vision.loadYoloModel(
      labels: 'assets/labels.txt',
      modelPath: 'assets/newyolov8n.tflite',
      modelVersion: "yolov8",
      quantization: true,
      numThreads: 2,
      useGpu: true);
}

Future<bool> yoloOnImage(FlutterVision vision, String imagePath) async {
  print("Checking image: "+imagePath);
  final byte = await File(imagePath).readAsBytes();
  final image = img.decodeImage(byte);
  final result = await vision.yoloOnImage(
      bytesList: byte,
      imageHeight: image!.height,
      imageWidth: image.width,
      iouThreshold: 0.9,
      confThreshold: 0.1,
      classThreshold: 0.2);
  print(result);
  if (result.isNotEmpty) {
    for (final x in result) {
      print("On image path"+imagePath+". Found tag: "+x['tag']);
      if (x['tag'] == 'person') {
        return true;
      }
    }
    return false;
  }
  return false;
}