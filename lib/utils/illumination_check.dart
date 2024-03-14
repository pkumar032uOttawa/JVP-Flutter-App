import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_frame_extractor/video_frame_extractor.dart';
import 'package:image/image.dart' as img;

Future<double> getIlluminationValue(String imagePath) async {
  final imageBytes = await File(imagePath).readAsBytes();
  final image = img.decodeImage(imageBytes);

  // Need more logic here
  if (image == null) {
    print("isIlluminationBelowThreshold: No image");
    return -1;
  };

  double totalBrightness = 0;
  for (var pixel in image) {
      double brightness = (pixel.r + pixel.b + pixel.g) / 3;
      totalBrightness += brightness;
  }

  double averageBrightness = totalBrightness / (image.width * image.height);
  print("the averageBrightness for " +imagePath+" is "+averageBrightness.toString());
  return averageBrightness;
}

// Return
// 0 if too dark
// 1 if the light is not stable
// 2 if good
Future<int> checkIlluminationValues(List<String> imagePaths, double skinBrightness, {double changeThreshold=30}) async {
  double darkThreshold = calculateIlluminationThreshold(skinBrightness);
  print("!!!!!!! skinBrightness: "+ skinBrightness.toString());
  print("!!!!!!! darkThreshold: "+ darkThreshold.toString());
  List<double> illuminations = [];
  double maxIllu = 0;
  double minIllu = 255;
  for (String path in imagePaths) {
    double currentIll = await getIlluminationValue(path);
    if(currentIll > maxIllu) maxIllu = currentIll;
    if(currentIll < minIllu) minIllu = currentIll;

    final brightEnough = currentIll > darkThreshold;
    if (!brightEnough) return 0; // If any image fails the basic illumination check, return early
  }

  if(maxIllu-minIllu > changeThreshold) return 1;
  else return 2;
}


double calculateIlluminationThreshold(double skinBrightness, {double baseThreshold = 60}) {
  // Define the range of skin brightness (255 is the max value for RGB channels)
  double minSkinBrightness = 51; // Approximately the brightness of the darkest skin
  double maxSkinBrightness = 240; // Approximately the brightness of the lightest skin

  // Normalize skin brightness to a 0-1 scale
  double normalizedBrightness = 50 * (skinBrightness - minSkinBrightness) / (maxSkinBrightness - minSkinBrightness) ;

  return baseThreshold + normalizedBrightness; // should be (60, 110)
}

