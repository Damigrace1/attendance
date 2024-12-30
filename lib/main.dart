import 'package:flutter/material.dart';
import 'package:qr_attendance_system/app/app.bottomsheets.dart';
import 'package:qr_attendance_system/app/app.dialogs.dart';
import 'package:qr_attendance_system/app/app.locator.dart';
import 'package:qr_attendance_system/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

late final FirebaseApp app;
late final FirebaseAuth auth;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  app = await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyCJoSpZMWpYhK4mGfEe3MWuIO9-KPyCLrI',
        appId: '1:408399301872:android:a5ba1b460611c1a3f38635',
        messagingSenderId: '408399301872',
        projectId: 'attendance-49b75',
        storageBucket: 'attendance-49b75.appspot.com',
      )
  );
  auth = FirebaseAuth.instanceFor(app: app);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 850),
        minTextAdapt: true,
        builder: (_, child) {
          return MaterialApp(
            initialRoute: Routes.startupView,
            onGenerateRoute: StackedRouter().onGenerateRoute,
            navigatorKey: StackedService.navigatorKey,
            navigatorObservers: [
              StackedService.routeObserver,
            ],
          );
        });
  }
}
