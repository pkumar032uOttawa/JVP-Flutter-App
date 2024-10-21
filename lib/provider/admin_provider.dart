import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jvp_app/models/ModelProvider.dart';

class AdminProvider extends ChangeNotifier {

  List<UserReport>? _userReports;
  get userReports => _userReports;

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

  Future<List<UserReport>?> readAllReports() async {
    try {
      _userReports = await Amplify.DataStore.query(
        UserReport.classType,
      );
      return _userReports;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<User>?> getAllUsers() async {
    try {
      final reports = await Amplify.DataStore.query(
        User.classType,
      );
      return reports;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> submitFeedback(String feedback, String reportId) async {
    try {
      final report = await readReportsByReportId(reportId);
      if (report != null) {
        final userReport = report.first;
        final updatedObject = userReport.copyWith(
          feedbackStatus: FeedbackStatus.GIVEN,
          commentsByDoctor: feedback,
        );
        await Amplify.DataStore.save(updatedObject);
        final item = _userReports?.firstWhere((report) => report.id == reportId);
        _userReports?.remove(item);
        _userReports?.add(updatedObject);
        print('Updated object to ${updatedObject.toString()}');
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<UserReport>?> readReportsByReportId(String id) async {
    try {
      final report = await Amplify.DataStore.query(
        UserReport.classType,
        where: UserReport.ID.eq(id),
      );
      return report;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
