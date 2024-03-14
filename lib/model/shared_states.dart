import 'package:flutter/material.dart';
class SharedState with ChangeNotifier {
  bool _isAccelerometerValid = false;
  double _skinBrightness = 255;
  String _username = "";

  bool get isAccelerometerValid => _isAccelerometerValid;
  double get skinBrightness => _skinBrightness;
  String get username => _username;

  set isAccelerometerValid(bool newValue) {
    _isAccelerometerValid = newValue;
    print("!!!!!! The _isAccelerometerValid is now: " + _isAccelerometerValid.toString());
    notifyListeners();  // Notify all listening widgets of the change.
  }
  set skinBrightness(double newValue) {
    _skinBrightness = newValue;
    print("!!!!!! The skinColor is now: " + _skinBrightness.toString());
    notifyListeners();  // Notify all listening widgets of the change.
  }
  set username(String newValue) {
    _username = newValue;
    print("!!!!!! The _username is now: " + _username.toString());
    notifyListeners();  // Notify all listening widgets of the change.
  }
}