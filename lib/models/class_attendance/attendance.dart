import 'package:cloud_firestore/cloud_firestore.dart';

class Attendance {
  String studentId;
  String studentName;
  String deviceId;
  Timestamp timestamp;
  bool isPresent;

  Attendance({
    required this.studentId,
    required this.studentName,
    required this.timestamp,
    required this.deviceId,
    this.isPresent = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'studentName': studentName,
      'deviceId': deviceId,
      'timestamp': FieldValue.serverTimestamp(),
      'isPresent': isPresent,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      studentId: map['studentId'] as String,
      studentName: map['studentName'] as String,
      deviceId: map['deviceId'] as String,
      timestamp: map['timestamp'] ?? Timestamp.now(),
      isPresent: map['isPresent'] as bool? ?? true,
    );
  }
}