import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_decoration.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/mark_attendance_qr.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/widgets/decorated_container.dart';
import 'package:qr_attendance_system/ui/views/profile/screens/profile_view.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/custom_textfield.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:stacked/stacked.dart';

import '../class_attendance_viewmodel.dart';

class NewAttendance extends StackedView<ClassAttendanceViewModel> {
  static route({required String text, required Color color}) =>
      MaterialPageRoute(
        builder: (context) => NewAttendance(
          text: text,
          color: color,
        ),
      );
  final String text;
  final Color color;
  const NewAttendance({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ClassAttendanceViewModel viewModel,
    Widget? child,
  ) {
    return BaseScaffold(
      backgroundColor: color,
      bodyColor: AppPallete.backgroundColor,
      appBarchild: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (text == 'staff') {
                    Navigator.push(
                        context,
                        ProfileView.route(
                          text: text,
                          color: color,
                        ));
                  } else {
                    Navigator.push(
                        context,
                        MarkAttendanceQr.route(
                          text: text,
                          color: color,
                        ));
                  }
                },
                child: CircleAvatar(
                  radius: 40,
                  child: Image.asset(AppImage.avatarImage),
                ),
              ),
              Text(
                'anifowope ayodele'.toUpperCase(),
                style: AppTextstyle.profileTextStyleLarge,
              ),
              const Spacer(),
              // Align(
              //   alignment: Alignment.center,
              //   child: Text(
              //     'welcome onboard!'.toUpperCase(),
              //     style: AppTextstyle.labelTextStyleLarge,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      bodychild: Column(
        children: [
          // Row forces the container to take full width
          TextContainer(
            width: 280,
            textColor: AppPallete.black,
            color: AppPallete.transparent,
            text: text == 'staff'
                ? 'YOUR class attendanceS'.toUpperCase()
                : 'mark attendance'.toUpperCase(),
          ),
          verticalSpaceLarge,

          text == 'staff' ? staffWidget(context) : studentWidget(context),
        ],
      ),
    );
  }

  Widget staffWidget(BuildContext context) => Expanded(
        child: ListView(
          children: [
            const CustomTextfield(
              hintText: 'ENTER COURSE TITLE',
            ),
            const CustomTextfield(
              hintText: 'ENTER COURSE CODE',
            ),
            const CustomTextfield(
              hintText: 'ENTER LECTURE TITLE',
            ),
            const CustomTextfield(
              hintText: 'ENTER LECTURE VENUE',
            ),
            DecorContainerRow(
              children: [
                Text(
                  'DATE',
                  style: AppTextstyle.bodyTextStyle,
                ),
                horizontalSpaceMedium,
                Text(
                  'DD',
                  style: AppTextstyle.bodyTextStyle,
                ),
                horizontalSpaceSmall,
                Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: AppDecoration.boxDecor,
                ),
                horizontalSpaceSmall,
                Text(
                  'MM',
                  style: AppTextstyle.bodyTextStyle,
                ),
                horizontalSpaceSmall,
                Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: AppDecoration.boxDecor,
                ),
                horizontalSpaceSmall,
                Text(
                  'YYYY',
                  style: AppTextstyle.bodyTextStyle,
                ),
                horizontalSpaceSmall,
                Container(
                  width: 60.w,
                  height: 30.h,
                  decoration: AppDecoration.boxDecor,
                ),
              ],
            ),
            verticalSpaceSmall,
            DecorContainerRow(
              children: [
                Text(
                  'TIME',
                  style: AppTextstyle.bodyTextStyle,
                ),
                horizontalSpaceLarge,
                Container(
                  alignment: Alignment.center,
                  width: 80.w,
                  height: 30.h,
                  decoration: AppDecoration.boxDecor,
                  child: Text(
                    '13:35',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                ),
              ],
            ),
            verticalSpaceSmall,
            GeneralButton(
              text: 'GENERATE QR CODE',
              buttonColor: AppPallete.darkPurpleColor,
              width: double.infinity,
              onTap: () {
                Navigator.push(
                    context,
                    MarkAttendanceQr.route(
                      text: text,
                      color: color,
                    ));
              },
            ),
          ],
        ),
      );
  Widget studentWidget(BuildContext context) => Column(
        children: [
          const Row(),
          Text(
            'scan qr code to mark attendance'.toUpperCase(),
            style: AppTextstyle.bodyTextStyleMedium,
          ),
          Container(
            height: 205.h,
            width: 205.w,
            decoration: AppDecoration.greyDecor,
          ),
          verticalSpaceSmall,
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MarkAttendanceQr.route(
                    text: text,
                    color: color,
                  ));
            },
            child: Container(
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
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'csc 101'.toUpperCase(),
                style: AppTextstyle.bodyTextStyle,
              ),
              Text(
                'dr. anifowope a.s'.toUpperCase(),
                style: AppTextstyle.bodyTextStyle,
              ),
              Text(
                '02/09/2024',
                style: AppTextstyle.bodyTextStyle,
              ),
              Text(
                'csc 101'.toUpperCase(),
                style: AppTextstyle.bodyTextStyle,
              ),
              Text(
                '12:00pm',
                style: AppTextstyle.bodyTextStyle,
              ),
              verticalSpaceMedium,
            ],
          ),
        ],
      );

  @override
  ClassAttendanceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ClassAttendanceViewModel();
}
