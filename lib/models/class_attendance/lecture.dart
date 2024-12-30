import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class Lecture {
  String lectureId;
  String lecturerId;
  String? lecturer;
  String? venue;
  String courseTitle;
  String courseCode;
  Timestamp startTime;
  bool isAttendanceOpen;
  GeoPoint position;

  Lecture({
    required this.lectureId,
    required this.lecturerId,
    required this.courseTitle,
    required this.startTime,
     this.lecturer,
    this.venue,
    required this.isAttendanceOpen,
    required this.courseCode,
    required this.position
  });

  Map<String, dynamic> toMap() {
    return {
      'lectureId': lectureId,
      'lecturerId': lecturerId,
      'lecturer': lecturer,
      'courseTitle': courseTitle,
      'startTime':  startTime,
      'venue': venue,
      'isAttendanceOpen': isAttendanceOpen,
      'courseCode': courseCode,
      'position' : position
    };
  }

  factory Lecture.fromMap(Map<String, dynamic> map) {
    return Lecture(
      lectureId: map['lectureId'] as String,
      lecturerId: map['lecturerId'] as String,
      courseTitle: map['courseTitle'] as String,
      lecturer: map['lecturer'] as String,
      startTime: map['startTime'] ?? Timestamp.now(),
      venue: map['venue'],
      position:  map['position']?? GeoPoint(0,0),
      isAttendanceOpen: map['isAttendanceOpen'] as bool,
      courseCode: map['courseCode'] as String,
    );
  }
}
