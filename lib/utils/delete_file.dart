import 'package:path_provider/path_provider.dart';
import 'dart:io';

void deleteCacheMp4Files() async {
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;
  print("Temp path is: " + tempPath);
  await deleteMp4Files(tempPath);
}




Future<void> deleteMp4Files(String path) async {
  final directory = Directory(path);
  try {
    // Check if directory exists
    if (await directory.exists()) {
      // List all files in the directory
      List<FileSystemEntity> files = directory.listSync();

      // Print files before deletion
      print("Files before deletion:");
      files.forEach((file) {
        print(file.path);
      });

      // Iterate through all the files in the directory
      for (FileSystemEntity file in files) {
        // Check if file path ends with '.mp4'
        // if (file.path.endsWith('.mp4')) {
          // Delete the file
        await file.delete(recursive: true);
        print("Deleted: ${file.path}");
        // }
      }

      // Print files after deletion
      print("Files after deletion:");
      directory.listSync().forEach((file) {
        print(file.path);
      });
    } else {
      print("Directory does not exist: $path");
    }
  }
  catch (e) {
    print("An error occurred: $e");
  }
}

Future<void> deletePngFiles(String path) async {
  final directory = Directory(path);
  try {
    // Check if directory exists
    if (await directory.exists()) {
      // List all files in the directory
      List<FileSystemEntity> files = directory.listSync();
      for (FileSystemEntity file in files) {
        if (file.path.endsWith('.png')) {
          await file.delete();
          print("Deleted: ${file.path}");
        }
      }
    } else {
      print("Directory does not exist: $path");
    }
  }
  catch (e) {
    print("An error occurred: $e");
  }
}