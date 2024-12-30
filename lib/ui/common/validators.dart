
import 'package:flutter/cupertino.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/class_attendance_viewmodel.dart';

class Validator {
  static String? validateEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    }
    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  static bool validateHour(String? value){
    if (value == null || value.isEmpty) {
      return false;
    }

    // Convert the value to an integer
    final int? time = int.tryParse(value);

    if (time == null) {
      return false;
    }

    if (time < 0 || time > 24) {
      return false;
    }

    return true; // Valid input
  }
}
