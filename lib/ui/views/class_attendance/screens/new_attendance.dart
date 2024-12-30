import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_decoration.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/models/auth/user.dart';
import 'package:qr_attendance_system/models/class_attendance/attendance.dart';
import 'package:qr_attendance_system/models/class_attendance/lecture.dart';
import 'package:qr_attendance_system/services/att_functions.dart';
import 'package:qr_attendance_system/services/firebase_services.dart';
import 'package:qr_attendance_system/ui/common/date_input_widget.dart';
import 'package:qr_attendance_system/ui/common/formatter.dart';
import 'package:qr_attendance_system/ui/common/show_toast.dart';
import 'package:qr_attendance_system/ui/common/time_input_widget.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/common/validators.dart';
import 'package:qr_attendance_system/ui/dialogs/loading.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/mark_attendance_qr.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/widgets/decorated_container.dart';
import 'package:qr_attendance_system/ui/views/profile/screens/profile_view.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/custom_textfield.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';

import '../../../dialogs/confirmation_dialog.dart';
import '../class_attendance_viewmodel.dart';

class NewAttendance extends StackedView<ClassAttendanceViewModel> {
  static route(
          {required String text,
          required Color color,
          Lecture? selectedLecture}) =>
      MaterialPageRoute(
        builder: (context) => NewAttendance(
          text: text,
          color: color,
          selectedLecture: selectedLecture,
        ),
      );
  final String text;
  final Color color;
  final Lecture? selectedLecture;
  const NewAttendance({
    Key? key,
    required this.text,
    required this.color,
    this.selectedLecture,
  }) : super(key: key);
  static final TextEditingController courseTitle = TextEditingController();
  static final TextEditingController courseCode = TextEditingController();
  static final TextEditingController lecture = TextEditingController();
  static final TextEditingController venue = TextEditingController();
  static final TextEditingController departmentController =
      TextEditingController();
  static final TextEditingController levelController = TextEditingController();
  @override
  Widget builder(
    BuildContext context,
    ClassAttendanceViewModel viewModel,
    Widget? child,
  ) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: color,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              ProfileView.route(
                                text: text,
                                color: color,
                              ));
                        },
                        child: CircleAvatar(
                          radius: 40,
                          child: Image.asset(AppImage.avatarImage),
                        ),
                      ),
                      Text(
                        ( user!.displayName == null || user.displayName == '')?
                        user.email!.toUpperCase() :  user.displayName!.toUpperCase(),
                        style: AppTextstyle.profileTextStyleLarge
                            .copyWith(color: AppPallete.backgroundColor),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -20,
                left: -40,
                child: CustomPaint(
                  painter: CurvedContainer(Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 26.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  )),
              child: Column(
                children: [
                  Text(
                    text == 'staff'
                        ? 'Create new attendance'.toUpperCase()
                        : 'scan qr code to mark attendance'.toUpperCase(),
                    style: AppTextstyle.buttonTextStyle
                        .copyWith(color: AppPallete.black),
                  ),
                  verticalSpaceMedium,
                  text == 'staff'
                      ? staffWidget(context, viewModel)
                      : studentWidget(
                          context,
                          selectedLecture!,
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget staffWidget(BuildContext context, ClassAttendanceViewModel viewModel) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return Expanded(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 12,
              ),
              CustomTextfield(
                controller: courseTitle,
                hintText: 'ENTER COURSE TITLE',
                validator: (v) => Validator.validateEmpty(v),
              ),
              CustomTextfield(
                controller: courseCode,
                hintText: 'ENTER COURSE CODE',
                validator: (v) => Validator.validateEmpty(v),
              ),
              CustomTextfield(
                controller: venue,
                validator: (v) => Validator.validateEmpty(v),
                hintText: 'ENTER LECTURE VENUE',
              ),
              const DateInputRow(),
              verticalSpaceSmall,
              const TimeInputRow(),
              verticalSpaceSmall,
              GeneralButton(
                busy: viewModel.isBusy,
                text: 'GENERATE QR CODE',
                buttonColor: AppPallete.darkPurpleColor,
                width: double.infinity,
                onTap: () async {
                  if (!_formKey.currentState!.validate()) return;
                  if (!validTime) return;
                  viewModel.addLecture(
                      courseTitle: courseTitle.text,
                      venue: venue.text,
                      lecturer:
                          FirebaseAuth.instance.currentUser?.displayName ?? '',
                      courseCode: courseCode.text,
                      context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget studentWidget(BuildContext context, Lecture lecture) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 205.w,
            height: 205.w,
            child: QRView(
              key: GlobalKey(),
              onQRViewCreated: (controller) {
                controller.scannedDataStream.listen((scanData) async {
                  controller.stopCamera();
                  if (scanData.code != null) {
                    if (lecture.lectureId != scanData.code) {
                      showToast(
                          context, 'QR code is not for the selected lecture.',
                          duration: Duration(seconds: 5));
                      Navigator.pop(context);
                    } else {
                      showCustomDialog(context, 'Submitting...');
                      final userModel = await FirestoreService().readUser();
                      final res = await FirestoreService().markAttendance(
                          scanData.code!,
                          Attendance(
                              studentId: userModel!.studentId!,
                              studentName: userModel.name!,
                              deviceId: await AttFunctions.getDeviceId() ?? '',
                              timestamp: Timestamp.now()));
                      Navigator.pop(context);
                      if (res != null) {
                        Navigator.pop(context);
                        showToast(context, res, duration: Duration(seconds: 5));
                        return;
                      }

                      Navigator.pushReplacement(
                          context,
                          MarkAttendanceQr.route(
                              text: text, color: color, lecture: lecture));
                    }

                  }
                });
              },
            ),
          ),
          verticalSpaceSmall,
          Container(
            width: 200.w,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: AppDecoration.greyDecor
                .copyWith(color: AppPallete.primaryColor),
            child: Text(
              'scan qr code'.toUpperCase(),
              style: AppTextstyle.buttonTextStyle,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 12.h,
              ),
              Text(
                selectedLecture!.courseCode.toUpperCase(),
                style: AppTextstyle.bodyTextStyleSmall,
              ),
              Text(
                selectedLecture!.lecturer?.toUpperCase() ?? '',
                style: AppTextstyle.bodyTextStyleSmall,
              ),
              Text(
                SFormatter.formatDate(selectedLecture?.startTime.toDate()),
                style: AppTextstyle.bodyTextStyleSmall,
              ),
              Text(
                selectedLecture!.courseCode.toUpperCase(),
                style: AppTextstyle.bodyTextStyleSmall,
              ),
              Text(
                SFormatter.formatTime(selectedLecture!.startTime.toDate()),
                style: AppTextstyle.bodyTextStyleSmall,
              ),
              verticalSpaceMedium,
            ],
          ),
        ],
      ),
    );
  }

  @override
  ClassAttendanceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ClassAttendanceViewModel();
}
