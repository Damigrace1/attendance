import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';
import 'package:qr_attendance_system/app/app.locator.dart';
import 'package:qr_attendance_system/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../core/theme/app_pallete.dart';
import '../../../services/firebase_services.dart';
import '../class_attendance/class_attendance_viewmodel.dart';
import '../class_attendance/screens/class_attendance_view.dart';

class StartupViewModel extends BaseViewModel {
  static NavigationService _navigationService = locator<NavigationService>();

  static  loadUser(BuildContext context){

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
         await  Future.delayed(Duration(seconds: 3));
      if (user != null) {
        final userModel = await  FirestoreService().readUser();
        if(userModel == null ){
          _navigationService.replaceWithAuthView();
        }
        else if(context.mounted) {
          Navigator.pushAndRemoveUntil(
              context,
              ClassAttendanceView.route(
                text: userModel.userType ?? 'Idkn',
                color: userModel.userType == 'staff'
                    ? AppPallete.primaryColor
                    : AppPallete.secondaryColor, userModel: userModel,
              ),
                  (Route r)=> false);
        }
      }
      else{
        _navigationService.replaceWithAuthView();
      }
    });
  }

  // Place anything here that needs to happen before we get into the application
  // static Future runStartupLogic() async {
  //   await Future.delayed(const Duration(seconds: 1));
  //   _navigationService.replaceWithAuthView();
  // }
}
