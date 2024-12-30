import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/models/class_attendance/lecture.dart';
import 'package:qr_attendance_system/services/firebase_services.dart';
import 'package:qr_attendance_system/ui/common/formatter.dart';
import 'package:qr_attendance_system/ui/common/show_toast.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/all_attended_students.dart';
import 'package:qr_attendance_system/ui/views/profile/screens/profile_view.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:stacked/stacked.dart';

import '../class_attendance_viewmodel.dart';

class MarkAttendanceQr extends StackedView<ClassAttendanceViewModel> {
  static route({required String text,
    required Color color,
     Lecture? lecture,
  }) =>
      MaterialPageRoute(
        builder: (context) => MarkAttendanceQr(
          text: text,
          color: color,
          lecture: lecture,
        ),
      );
  final String text;
  final Lecture? lecture;
  final Color color;
  const MarkAttendanceQr({
    Key? key,
    required this.text,
    required this.color,
    required this.lecture,
  }) : super(key: key);


  @override
  Widget builder(
    BuildContext context,
    ClassAttendanceViewModel viewModel,
    Widget? child,
  ) {
    final user = FirebaseAuth.instance.currentUser;

    return BaseScaffold(
      backgroundColor: color,
      bodyColor: AppPallete.backgroundColor,
      appBarchild: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  text == 'staff' ?
                  Column(
                    children: [
                      Switch(value: viewModel.closeAttendance, onChanged: (v){
                        viewModel.toggleCloseAttendance(v);
                        showToast(context, 'You have '
                            '${viewModel.closeAttendance ? 'closed' : 'opened'}'
                                    ' attendance for this lecture'
                        );
                        FirestoreService().updateAttendanceStatus(lecture!.lectureId, !v);
                        FirestoreService().updateLectureLocation(lecture!.lectureId);

                      }),
                      Text(viewModel.closeAttendance ? 'CLOSED' : 'OPENED',
                      style: AppTextstyle.bodyTextStyleMedium.copyWith(color: Colors.white),)
                    ],
                  ) : SizedBox()
                ],
              ),
              Text(
                ( user!.displayName == null || user.displayName == '')?
                user.email!.toUpperCase() :  user.displayName!.toUpperCase(),
                style: AppTextstyle.profileTextStyleLarge,
              ),
              const Spacer(),

            ],
          ),
        ),
      ),
      bodychild: Column(
        children: [
          const Row(),
          TextContainer(
            width: 280,
            textColor: AppPallete.black,
            color: AppPallete.transparent,
            text: text == 'staff' ? 'NEW CLASS ATTENDANCE' : 'MARK ATTENDANCE',
          ),
          text == 'staff' ? staffWidget(context,viewModel) : studentWidget(lecture!),
        ],
      ),
    );
  }

  Widget studentWidget (Lecture l){
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l.courseCode.toUpperCase(),
            style: AppTextstyle.bodyTextStyle,
          ),
          Text(
            l.courseTitle.toUpperCase(),
            style: AppTextstyle.bodyTextStyle,
          ),
          Text(
            l.lecturer!.toUpperCase(),
            style: AppTextstyle.bodyTextStyle,
          ),
          Text(
            SFormatter.formatDate( l.startTime.toDate(),),
            style: AppTextstyle.bodyTextStyle,
          ),

          Text(
            SFormatter.formatTime(DateTime.now(),),
            style: AppTextstyle.bodyTextStyle,
          ),
          verticalSpaceMedium,
          Text(
            'attendance sucessfully marked'.toUpperCase(),
            style: AppTextstyle.bodyTextStyle,
          ),
           Align(
             alignment: Alignment.center,
             child: Icon(
              Icons.check_circle,
              color: AppPallete.primaryColor,
              size: 150,
                       ),
           ),
        ],
      ),
    );
  }

  Widget  staffWidget(BuildContext context, ClassAttendanceViewModel viewModel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalSpaceMedium,
        if(!viewModel.closeAttendance)
        QrImageView(data: lecture!.lectureId,
          size: 153.w,),
        verticalSpaceMedium,
        if(viewModel.closeAttendance)
          Text
            ('Attendance is currently closed for this lecture. Please toggle the switch above to open it when you are at the '
              'lecture venue as this location will be checked against the location of students and attendance will be marked only '
              'if they are around the lecture venue.',
            textAlign: TextAlign.center,
            style: AppTextstyle.bodyTextStyleSmall,),
        if(!viewModel.closeAttendance)
        TextContainer(
          width: 280.w,
          textColor: AppPallete.black,
          color: AppPallete.transparent,
          border: Border.all(color: AppPallete.black),
          text: 'scan to mark attendance',
        ),
        verticalSpaceMedium,
        GeneralButton(
            width: 280.w,
            onTap: (){
              Navigator.push(context,CupertinoPageRoute(builder: (context)=>
              AllAttendedStudents(lectureId: lecture!.lectureId)));
            },
            buttonColor: color, text: 'View attended students')
      ],
    );
  }

  @override
  void onViewModelReady(ClassAttendanceViewModel viewModel){
    if(lecture != null && text == 'staff') {
      viewModel.toggleCloseAttendance(!lecture!.isAttendanceOpen);
    }
  }
  @override
  ClassAttendanceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ClassAttendanceViewModel();
}
