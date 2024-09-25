import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jvp_app/models/ModelProvider.dart';
import 'dart:io' as io;
import 'package:aws_common/vm.dart';

class UserProvider extends ChangeNotifier {
  Future<void> createUser(String name, String email, String id) async {
    final user =
        User(id: id, name: name, email: email, userType: UserType.USER);
    try {
      await Amplify.DataStore.save(user);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> createUserReport(UserReport userReport) async {
    try {
      await Amplify.DataStore.save(userReport);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<List<User>> readAllUsers() async {
    try {
      final users = await Amplify.DataStore.query(User.classType);
      print(users.toString());
      return users;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<User?> readByUserId(String userId) async {
    try {
      final sexyObjects = await Amplify.DataStore.query(
        User.classType,
        where: User.ID.eq(userId),
      );

      if (sexyObjects.isEmpty) {
        print("No objects with ID: $userId");
        return null;
      }

      final sexyObject = sexyObjects.first;
      print(sexyObject.toString());
      return sexyObject;
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future<List<UserReport>?> readReportsByUserId(String userId) async {
    try {
      final sexyObjects = await Amplify.DataStore.query(
        UserReport.classType,
        where: UserReport.USERID.eq(userId),
      );
      if (sexyObjects.isEmpty) {
        print("No objects with ID: $userId");
        return null;
      }
      return sexyObjects;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateUserName(String userId, User updatedUser) async {
    try {
      final user = await readByUserId(userId);
      if (user != null) {
        final updatedObject = user.copyWith(
          name: updatedUser.name,
        );
        await Amplify.DataStore.save(updatedObject);
        print('Updated object to ${updatedObject.toString()}');
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      final user = await readByUserId(userId);
      if (user != null) {
        await Amplify.DataStore.delete(user);
        print('Deleted object with ID: ${user.id}');
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }
  Future<String> uploadIOFile(String filePath) async {
    try {
      final awsFile = AWSFilePlatform.fromFile(io.File(filePath));
      final uploadResult = await Amplify.Storage.uploadFile(
        path: StoragePath.fromString( 'upload/file.jpeg'),
        localFile: awsFile,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        },
      ).result;
      return uploadResult.uploadedItem.path;
    } on StorageException catch (e) {
      rethrow;
    }
  }
}