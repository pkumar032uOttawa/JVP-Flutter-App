import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jvp_app/models/ModelProvider.dart';
import 'dart:io' as io;
import 'package:aws_common/vm.dart';
import 'package:uuid/uuid.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';

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

  Future<User?> getUserByUserId(String userId) async {
    try {
      final user = await Amplify.DataStore.query(
        User.classType,
        where: User.ID.eq(userId),
      );

      if (user.isEmpty) {
        print("No objects with ID: $userId");
        return null;
      }

      final sexyObject = user.first;
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
      return sexyObjects;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> updateUserName(String userId, User updatedUser) async {
    try {
      final user = await getUserByUserId(userId);
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
      final user = await getUserByUserId(userId);
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
      var uuid = Uuid();
      final user = await Amplify.Auth.getCurrentUser();
      String randomId = uuid.v4();
      final awsFile = AWSFilePlatform.fromFile(io.File(filePath));
      final fileId = randomId;
      final uploadResult = await Amplify.Storage.uploadFile(
        path: StoragePath.fromString( 'upload/videos/${user.userId}/$fileId'),
        localFile: awsFile,
        onProgress: (progress) {
          safePrint('Fraction completed: ${progress.fractionCompleted}');
        },
      ).result;
      return 'upload/videos/${user.userId}/$fileId';
    } on StorageException catch (e) {
      rethrow;
    }
  }

  Future<String> getUrl(String path) async {
    try {
      final result = await Amplify.Storage.getUrl(
        path: StoragePath.fromString(path),
        options: const StorageGetUrlOptions(
          pluginOptions: S3GetUrlPluginOptions(
            validateObjectExistence: true,
            expiresIn: Duration(days: 1),
          ),
        ),
      ).result;
      return result.url.toString();
    } on StorageException catch (e) {
      rethrow;
    }
  }
}
