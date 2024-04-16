import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:jvp_app/utils/file_extension.dart';
import 'dart:convert';

Future<String> uploadVideo(String filePath, String username, double skinColor) async {
  try {
    var uri = Uri.parse('https://jvp.cepheus0.com:2531/videoupload');
    var request = http.MultipartRequest('POST', uri);

    // JSON object with username and double value
    Map<String, String> additionalData = {
      'username': username,
      'skinColor': skinColor.toString(), // Convert double to String
    };

    // Add JSON object to the fields of the request
    request.fields.addAll(additionalData);

    String newFileName = username+getFileExtension(filePath);
    print("newFileName"+newFileName);
    // Attach the video file to the request
    request.files.add(await http.MultipartFile.fromPath('video', filePath, filename: newFileName, contentType: MediaType('video', 'mp4')));

    // Send the request
    var response = await request.send();
    String responseBody = await response.stream.bytesToString();
    var decodedJson = jsonDecode(responseBody);

    if (response.statusCode == 200) {
      print('Video uploaded successfully');
      print('Success response body: $responseBody ');
    } else {
      print('Failed to upload video');
      print('Error response body: $responseBody ');
    }
    return decodedJson['message'];
  }

  catch (e) {
    print('Unexpected error uploading video: $e');
    if (e is SocketException) {
      print('Bad internet');
      return 'Oops, No Internet! Try Again';
    }
    else{
      return '$e';
    }
  }
}
