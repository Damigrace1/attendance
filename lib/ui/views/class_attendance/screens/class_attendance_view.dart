import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_decoration.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/new_attendance.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/widgets/decorated_container.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:stacked/stacked.dart';

import '../class_attendance_viewmodel.dart';

class ClassAttendanceView extends StackedView<ClassAttendanceViewModel> {
  static route({required String text, required Color color}) =>
      MaterialPageRoute(
        builder: (context) => ClassAttendanceView(
          text: text,
          color: color,
        ),
      );
  final String text;
  final Color color;
  const ClassAttendanceView({
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
              CircleAvatar(
                radius: 40,
                child: Image.asset(AppImage.avatarImage),
              ),
              Text(
                'anifowope ayodele'.toUpperCase(),
                style: AppTextstyle.labelTextStyleLarge,
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'welcome onboard!'.toUpperCase(),
                  style: AppTextstyle.labelTextStyleLarge,
                ),
              ),
            ],
          ),
        ),
      ),
      bodychild: Column(
        children: [
          // Row forces the container to take full width
          TextContainer(
            textColor: AppPallete.black,
            width: 280,
            color: AppPallete.transparent,
            text: text == 'staff'
                ? 'YOUR class attendanceS'.toUpperCase()
                : 'today’s attendance lists'.toUpperCase(),
          ),
          verticalSpaceLarge,
          text == 'staff' ? staffWidget(context) : studentWidget(context),
        ],
      ),
    );
  }

  Widget staffWidget(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GeneralButton(
            text: 'scedule new class',
            buttonColor: AppPallete.darkPurpleColor,
            width: double.infinity,
            onTap: () {
              Navigator.push(
                  context,
                  NewAttendance.route(
                    text: text,
                    color: color,
                  ));
            },
          ),
          verticalSpaceSmall,
          DecorContainerRow(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'csc 101',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                  Text(
                    'visual basics',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                  Text(
                    '02/09/2024',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                ],
              ),
              horizontalSpaceSmall,
              Text(
                '12:00pm',
                style: AppTextstyle.bodyTextStyle,
              ),
            ],
          ),
          verticalSpaceSmall,
          DecorContainerRow(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'csc 101',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                  Text(
                    'visual basics',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                  Text(
                    '02/09/2024',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                ],
              ),
              horizontalSpaceSmall,
              Text(
                '10:00am',
                style: AppTextstyle.bodyTextStyle,
              ),
            ],
          ),
        ],
      );

  Widget studentWidget(BuildContext context) => Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  NewAttendance.route(
                    text: text,
                    color: color,
                  ));
            },
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 9,
                  backgroundColor: AppPallete.primaryColor,
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
          ),
          verticalSpaceMedium,
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            // width: 205,
            decoration: AppDecoration.boxDecor
                .copyWith(color: AppPallete.backgroundColor),
            child: Text(
              'csc 101 - VISUAL BASICS'.toUpperCase(),
              style: AppTextstyle.buttonTextStyle.copyWith(
                color: AppPallete.black,
              ),
            ),
          ),
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
          verticalSpaceMedium,
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            // width: 205,
            decoration: AppDecoration.boxDecor
                .copyWith(color: AppPallete.backgroundColor),
            child: Text(
              'csc 102 - JAVA'.toUpperCase(),
              style: AppTextstyle.buttonTextStyle.copyWith(
                color: AppPallete.black,
              ),
            ),
          ),
          verticalSpaceSmall,
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            // width: 205,
            decoration: AppDecoration.boxDecor
                .copyWith(color: AppPallete.backgroundColor),
            child: Text(
              'csc 101 - VISUAL BASICS'.toUpperCase(),
              style: AppTextstyle.buttonTextStyle.copyWith(
                color: AppPallete.black,
              ),
            ),
          ),
          verticalSpaceSmall,
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            // width: 205,
            decoration: AppDecoration.boxDecor
                .copyWith(color: AppPallete.backgroundColor),
            child: Text(
              'csc 101 - HTML'.toUpperCase(),
              style: AppTextstyle.buttonTextStyle.copyWith(
                color: AppPallete.black,
              ),
            ),
          ),
          verticalSpaceMedium,
        ],
      );
  @override
  ClassAttendanceViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ClassAttendanceViewModel();
}
