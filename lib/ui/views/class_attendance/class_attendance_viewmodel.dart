import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/models/auth/user.dart';
import 'package:qr_attendance_system/services/geo_services.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/mark_attendance_qr.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';

import '../../../models/class_attendance/lecture.dart';
import '../../../services/firebase_services.dart';
import '../../common/formatter.dart';
import '../../common/show_toast.dart';
import '../../dialogs/confirmation_dialog.dart';


DateTime startTime = DateTime.now().copyWith(minute: 0);
bool validTime = false;

class ClassAttendanceViewModel extends BaseViewModel {
  String lectureId = '';
  bool closeAttendance = false;
   String generateRandomId() {
     final random = Random();
     // Generate a random 16-digit number as a string
     String id = '';
     for (int i = 0; i < 16; i++) {
       id += random.nextInt(10).toString(); // Append a random digit (0-9) to the string
     }
     return id;
   }

   toggleCloseAttendance(bool v){
     closeAttendance = v;
     notifyListeners();
   }

    addLecture({
     required String courseTitle,
     required String courseCode,
     required String lecturer,
     required String venue,
     required BuildContext context,
})async{
     try{
       final cont = await showConfirmationDialog(context: context,
           title: 'Create New Lecture',
           content: 'You are about to schedule $courseCode lecture for ${SFormatter.formatDate(startTime)} at ${
           SFormatter.formatTime(startTime)
           }');
       if(cont == false )return ;
       setBusy(true);
       lectureId =  generateRandomId();
       Position pos = await GeoService.determinePosition();
       Lecture l =   Lecture(
           lectureId: lectureId,
           lecturer: lecturer,
           venue: venue,
           position: GeoPoint(pos.latitude, pos.longitude),
           lecturerId: FirebaseAuth.instance.currentUser!.uid,
           courseTitle: courseTitle,
           startTime: Timestamp.fromDate(startTime),
           isAttendanceOpen: false,
           courseCode: courseCode);

      await FirestoreService().addLecture(l);
      if (context.mounted) {
        closeAttendance = false;
        Navigator.pushReplacement(
            context,
            MarkAttendanceQr.route(
              text: 'staff',
              color: AppPallete.primaryColor,
              lecture: l
            ));
      }
     }
     catch (e) {
        showToast(context,
            'We could not create a record at this time. Try again');
      }
      finally {
        setBusy(false);
      }
    }

   Future<String?> scanQRCode(BuildContext c,Key qrKey)async{
     return await showDialog(context: c, builder: (c)=>
         Dialog(
           child:  SizedBox(
             height: 200,
             child: QRView(
               key: qrKey,
               onQRViewCreated: (controller){
                 controller.scannedDataStream.listen((scanData) {
                   controller.stopCamera();
                   if(scanData.code != null) {
                     print('message::::::::::::::${scanData.code}');
                     Navigator.pop(c,scanData.code);
                   }

                 });
               },
             ),
           ),
         )
     );
    }

    loadUserLectureData()async{
      setBusy(true);
      final userModel = await  FirestoreService().readUser();
     if(userModel!.userType == 'staff'){
       allMyLectures = await FirestoreService().getLecturesByLecturer(FirebaseAuth.instance.
       currentUser!.uid);
     }
     else{
       todayLectures = await FirestoreService().getTodayLectures();

     }
      setBusy(false);
    }
   List<Lecture>? todayLectures;
   List<Lecture> allMyLectures = [];
   
}
