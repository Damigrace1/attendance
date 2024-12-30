import 'package:flutter/cupertino.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/services/firebase_services.dart';
import 'package:qr_attendance_system/ui/common/app_colors.dart';
import 'package:qr_attendance_system/ui/common/show_toast.dart';
import 'package:qr_attendance_system/models/auth/user.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../class_attendance/screens/class_attendance_view.dart';
import '../../profile/screens/profile_view.dart';

class AuthViewModel extends BaseViewModel {

  Future<void> createUser(BuildContext context, UserModel userModel) async {
    setBusy(true);
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userModel.email ?? '', password: userModel.password ?? '');

      User? user = userCredential.user;

      if (user != null) {
        user.updateDisplayName(userModel.name);
       final u = await  FirestoreService().createUserDetails(user.uid, userModel.toFirestore());
        if (context.mounted && u != null) {
          Navigator.pushAndRemoveUntil(
              context,
              ClassAttendanceView.route(
                text: userModel.userType ?? 'Idkn',
                color: userModel.userType == 'staff'
                    ? AppPallete.primaryColor
                    : AppPallete.secondaryColor, userModel: u,
              ), (Route<dynamic> route) => false,);
        }
        else {
          return;
        }
      }
    }   catch (e) {
      if(context.mounted) {
        showToast(context, e.toString());
      }
      print("Failed to create user: $e");
    }
    finally {
      setBusy(false);
    }
  }

  Future<void> signInUser(
      BuildContext context,
  {
    required String email,
    required String pw,
}
      )async{

    setBusy(true);
    try {

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email, password: pw);

      User? user = userCredential.user;

      if (user != null) {
        final userModel = await  FirestoreService().readUser();
        if (context.mounted && userModel != null) {

            Navigator.pushAndRemoveUntil(
                context,
                ClassAttendanceView.route(
                    text: userModel.userType.toString(),
                    color:  AppPallete.primaryColor,
                  userModel: userModel
                ),
                  (Route<dynamic> route) => false,
            );

        }
        else {
          return;
        }
      }
    }
    on FirebaseAuthException
    catch (e){
    //  print(e.);
      showToast(context, e.message!.toUpperCase());
    }
    catch (e) {
      if(context.mounted) {
        showToast(context, e.toString());
      }
      print("Failed to sign in  user: $e");
    }

    finally {
      setBusy(false);
    }
  }
}
