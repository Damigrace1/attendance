import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_decoration.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/services/firebase_services.dart';
import 'package:qr_attendance_system/services/att_functions.dart';
import 'package:qr_attendance_system/ui/common/formatter.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/models/auth/user.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/new_attendance.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/widgets/decorated_container.dart';
import 'package:qr_attendance_system/ui/views/profile/screens/profile_view.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:stacked/stacked.dart';

import '../../../../models/class_attendance/lecture.dart';
import '../class_attendance_viewmodel.dart';
import 'mark_attendance_qr.dart';

class ClassAttendanceView extends StackedView<ClassAttendanceViewModel> {
  static route(
          {required String text,
          required Color color,
          required UserModel userModel}) =>
      MaterialPageRoute(
        builder: (context) => ClassAttendanceView(
          text: text,
          color: color,
          userModel: userModel,
        ),
      );
  final String text;
  final Color color;
  final UserModel userModel;
  const ClassAttendanceView(
      {Key? key,
      required this.text,
      required this.color,
      required this.userModel})
      : super(key: key);



  @override
  Widget builder(
    BuildContext context,
    ClassAttendanceViewModel viewModel,
    Widget? child,
  ) {
    final user = FirebaseAuth.instance.currentUser;
    return   Scaffold(
      backgroundColor: color ,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                        style: AppTextstyle.profileTextStyleLarge,
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
          SizedBox(height: 30.h,),
          Expanded(
            child: Container(
              padding:  EdgeInsets.symmetric(vertical: 0, horizontal: 26.w),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r),
                  )
              ),
              child: ListView(
                padding:  EdgeInsets.symmetric(vertical: 24.h, horizontal: 0),
                children: [
                  TextContainer(
                    textColor: AppPallete.black,
                    width: 280.w,
                    color: AppPallete.transparent,
                    text: text == 'staff'
                        ? 'YOUR class attendanceS'.toUpperCase()
                        : 'today’s attendance lists'.toUpperCase(),
                  ),
                  verticalSpaceMedium,
                  text == 'staff' ? staffWidget(context,viewModel) :
                  studentWidget(context,viewModel),
                ],
              ),
            ),
          )

        ],
      ),
    );
  }

  Widget staffWidget(BuildContext context,ClassAttendanceViewModel viewModel) {
     return  Column(
       mainAxisSize: MainAxisSize.min,
       children: [
         GeneralButton(
           text: 'schedule new class',
           buttonColor: AppPallete.darkPurpleColor,
           width: double.infinity,
           onTap: () async{
            await  Navigator.push(
                 context,
                 NewAttendance.route(
                   text: text,
                   color: color,
                 ));
            viewModel.loadUserLectureData();
           },
         ),
         verticalSpaceSmall,
         ListView.separated(
             padding:  EdgeInsets.only(top: 25.h),
             physics: NeverScrollableScrollPhysics(),
             itemBuilder: (context,index){
               Lecture l = viewModel.allMyLectures[index];
               return   InkWell(
                 onTap: ()async{

                   await Navigator.push(
                       context,
                       MarkAttendanceQr.route(
                           text: text,
                           color: color,
                           lecture: l
                       ));
                   viewModel.loadUserLectureData();
                 },
                 child: DecorContainerRow(
                   crossAxisAlignment: CrossAxisAlignment.end,
                   children: [
                     Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: [
                         Text(
                           l.courseCode,
                           style: AppTextstyle.bodyTextStyle,
                         ),
                         Text(
                           l.courseTitle,
                           style: AppTextstyle.bodyTextStyle,
                         ),
                         Text(
                           SFormatter.formatDate(l.startTime.toDate()),
                           style: AppTextstyle.bodyTextStyle,
                         ),
                       ],
                     ),
                     horizontalSpaceSmall,
                     Text(
                       SFormatter.formatTime(l.startTime.toDate()),
                       style: AppTextstyle.bodyTextStyle,
                     ),
                   ],
                 ),
               );
             },
             shrinkWrap: true,
             separatorBuilder: (_,__){
               return     verticalSpaceSmall;
             }, itemCount: viewModel.allMyLectures.length??0),
       ],
     );}

  Widget studentWidget(BuildContext context,ClassAttendanceViewModel viewModel) {
    List<Lecture> openAttendance = viewModel.todayLectures?.where((l)=>l.isAttendanceOpen).toList()??[];
    List<Lecture> closedAttendance = viewModel.todayLectures?.where((l)=>!l.isAttendanceOpen).toList()??[];
    if (viewModel.isBusy) {
      return Center(child: SizedBox(height: 20,width: 20,child: CircularProgressIndicator.adaptive(strokeWidth: 2,),),);
    } else {
      return ListView(
        physics: NeverScrollableScrollPhysics(),
        padding:  EdgeInsets.only(top: 34.h),
        shrinkWrap: true,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 9,
              backgroundColor: Colors.green,
            ),
            horizontalSpaceSmall,
            Text(
              'open attendances'.toUpperCase(),
              style: AppTextstyle.buttonTextStyle.copyWith(
                color: AppPallete.black,
              ),
            ),
          ],
        ),
        ListView.separated(
            padding:  EdgeInsets.only(top: 25.h),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
         return  InkWell(
           onTap: ()async{

             Navigator.push(
                 context,
                 NewAttendance.route(
                   text: text,
                   color: color,
                   selectedLecture: openAttendance[index]
                 ));
           },
           child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              // width: 205,
              decoration: AppDecoration.boxDecor
                  .copyWith(color: AppPallete.backgroundColor),
              child: Text(
                '${openAttendance[index].courseCode} - ${openAttendance[index].courseTitle}'.toUpperCase(),
                style: AppTextstyle.buttonTextStyle.copyWith(
                  color: AppPallete.black,
                ),
              ),
            ),
         );
        },
            shrinkWrap: true,
            separatorBuilder: (_,__){
          return verticalSpaceSmall;
        }, itemCount: openAttendance.length),
        verticalSpaceMedium,
        Row(
          children: [
            const CircleAvatar(
              radius: 9,
              backgroundColor: AppPallete.red,
            ),
            horizontalSpaceSmall,
            Text(
              'closed attendances'.toUpperCase(),
              style: AppTextstyle.buttonTextStyle.copyWith(
                color: AppPallete.black,
              ),
            ),
          ],
        ),
        ListView.separated(
            padding:  EdgeInsets.only(top: 25.h),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return  Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                // width: 205,
                decoration: AppDecoration.boxDecor
                    .copyWith(color: AppPallete.backgroundColor),
                child: Text(
                  '${closedAttendance[index].courseCode} - ${closedAttendance[index].courseTitle}'.toUpperCase(),
                  style: AppTextstyle.buttonTextStyle.copyWith(
                    color: AppPallete.black,
                  ),
                ),
              );
            },
            shrinkWrap: true,
            separatorBuilder: (_,__){
              return     verticalSpaceSmall;
            }, itemCount: closedAttendance.length),
        verticalSpaceSmall,
      ],
          );
    }
  }


  @override
  void onViewModelReady(ClassAttendanceViewModel viewModel){

    viewModel.loadUserLectureData();
  }

  @override
  ClassAttendanceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ClassAttendanceViewModel();
}
