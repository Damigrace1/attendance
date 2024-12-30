import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_attendance_system/services/geo_services.dart';
import 'package:qr_attendance_system/ui/common/show_toast.dart';

import '../models/auth/user.dart';
import '../models/class_attendance/attendance.dart';
import '../models/class_attendance/lecture.dart';
import 'att_functions.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserModel?> createUserDetails(String userId, Map<String, dynamic> userData) async {
    try {
      await _db.collection('users').doc(userId).set(userData);
      final userModel = await  FirestoreService().readUser();
      if(userModel == null )return null;
      return userModel;
    } catch (e) {
      print('Error creating user: $e');
      return null;

    }
  }

  Future<UserModel?> readUser({String? incId}) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot doc = await _db.collection('users').doc(incId ?? userId).get();
      if (doc.exists) {
        UserModel userModel = UserModel.fromFirestore(doc);
        return userModel;
      } else {
        print('User not found.');
        return null;
      }
    } catch (e) {
      print('Error reading user: $e');
      return null;
    }
  }

  // Update a user's data
  Future<void> updateUser(String userId, Map<String, dynamic> updates) async {
    try {
      await _db.collection('users').doc(userId).update(updates);
      print('User updated successfully.');
    } catch (e) {
      print('Error updating user: $e');
    }
  }

  // Delete a user
  Future<void> deleteUser(String userId) async {
    try {
      await _db.collection('users').doc(userId).delete();
      print('User deleted successfully.');
    } catch (e) {
      print('Error deleting user: $e');
    }

  }

  // Add a new lecture
  Future<void> addLecture(Lecture lecture) async {
    await _db.collection('lectures').doc(lecture.lectureId).set(lecture.toMap());
  }

  // Update the attendance status (open/close)
  Future<void> updateAttendanceStatus(String lectureId, bool isAttendanceOpen) async {
    await _db.collection('lectures').doc(lectureId).
    update({
      'isAttendanceOpen': isAttendanceOpen,
      'startTime' : Timestamp.now()
    });
  }

  Future<void> updateLectureLocation(String lectureId) async {
    Position pos =  await GeoService.determinePosition();
    GeoPoint geoPoint = GeoPoint(pos.latitude, pos.longitude);
    await _db.collection('lectures').doc(lectureId).
    update({"position" : geoPoint
    });
  }


  // Mark attendance for a student
  Future<String?> markAttendance(String lectureId, Attendance attendance) async {
    final lectureDoc = _db.collection('lectures').doc(lectureId);
    final DocumentSnapshot<Map<String, dynamic>> docSnapshot = await lectureDoc.get();
    Position currentPos = await GeoService.determinePosition();
    final lectureLocation = Lecture.fromMap(docSnapshot.data()??{}).position;
    final lectureSnapshot = await lectureDoc.get();

    // Check if student's device has not been used before

    final deviceId = await  AttFunctions.getDeviceId();
    if(deviceId != null) {
      final querySnapshot = await _db.collection('lectures').doc(lectureId).collection('Attendance')
     .where('deviceId', isEqualTo: deviceId).get();
      final res = querySnapshot.docs.isNotEmpty;
      if(res){
        return 'Sorry! You have already signed attendance with this device.';
      }
    }
    log("::;rec");
    // Check if student is around lecture area
    if(!AttFunctions.calculateRadialDistance(GeoPoint(currentPos.latitude, currentPos.longitude),
        lectureLocation, 150)){
      return 'Sorry! You cannot be signed in. You seem not to be in the lecture venue.';
    }

    // Check if attendance is still open
    if (!lectureSnapshot.exists && lectureSnapshot['isAttendanceOpen']){
      return 'Sorry! Attendance has been closed for this lecture';
    }

      await lectureDoc.collection('Attendance').doc(attendance.studentId.replaceAll('/', '_')).
      set(attendance.toMap());


    return null;
  }

  // Get attendance list for a lecture
  Future<List<Attendance>> getAttendanceList(String lectureId) async {
    final querySnapshot = await _db.collection('lectures').doc(lectureId).collection('Attendance').get();
    return querySnapshot.docs.map((doc) => Attendance.fromMap(doc.data())).toList();
  }

  // Get all lectures
  Future<List<Lecture>> getLectures() async {
    final querySnapshot = await _db.collection('lectures').get();
    return querySnapshot.docs.map((doc) => Lecture.fromMap(doc.data())).toList();
  }

  // Get a specific lecture by ID
  Future<Lecture?> getLectureById(String lectureId) async {
    final docSnapshot = await _db.collection('lectures').doc(lectureId).get();
    if (docSnapshot.exists) {
      return Lecture.fromMap(docSnapshot.data()!);
    }
    return null;
  }

  Future<List<Lecture>> getLecturesByLecturer(String lecturerId) async {
    try {
      // Query the Lectures collection where lecturerId matches
      final querySnapshot = await _db
          .collection('lectures')
          .where('lecturerId', isEqualTo: lecturerId)
          .get();

      // Convert the query results into a list of Lecture objects
      return querySnapshot.docs.map((doc) => Lecture.fromMap(doc.data())).toList();
    } catch (e) {
      print('Error fetching lectures by lecturer ID: $e');
      return [];
    }
  }

  Future<List<Lecture>> getTodayLectures()async{
    DateTime now = DateTime.now();

    DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    Timestamp startTimestamp = Timestamp.fromDate(startOfDay);
    Timestamp endTimestamp = Timestamp.fromDate(endOfDay);

    final querySnapshot = await _db.collection('lectures')
        .where('startTime', isGreaterThanOrEqualTo: startTimestamp)
        .where('startTime', isLessThanOrEqualTo: endTimestamp)
        .get();
    return querySnapshot.docs.map((doc) => Lecture.fromMap(doc.data())).toList();
  }
}
