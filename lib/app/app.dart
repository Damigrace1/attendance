import 'package:qr_attendance_system/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:qr_attendance_system/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:qr_attendance_system/ui/views/home/home_view.dart';
import 'package:qr_attendance_system/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:qr_attendance_system/ui/views/auth/screens/auth_view.dart';

import 'package:qr_attendance_system/ui/views/profile/screens/profile_view.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/class_attendance_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AuthView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: ClassAttendanceView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
