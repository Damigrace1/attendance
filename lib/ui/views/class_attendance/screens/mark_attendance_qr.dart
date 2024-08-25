import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/profile/screens/profile_view.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:stacked/stacked.dart';

import '../class_attendance_viewmodel.dart';

class MarkAttendanceQr extends StackedView<ClassAttendanceViewModel> {
  static route({required String text, required Color color}) =>
      MaterialPageRoute(
        builder: (context) => MarkAttendanceQr(
          text: text,
          color: color,
        ),
      );
  final String text;
  final Color color;
  const MarkAttendanceQr({
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
                  if (text != 'staff') {
                    Navigator.push(
                        context,
                        ProfileView.route(
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
          const Row(),
          TextContainer(
            width: 280,
            textColor: AppPallete.black,
            color: AppPallete.transparent,
            text: text == 'staff' ? 'NEW CLASS ATTENDANCE' : 'MARK ATTENDANCE',
          ),
          text == 'staff' ? staffWidget : studentWidget,
        ],
      ),
    );
  }

  Widget get studentWidget => Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
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
            Row(
              children: [
                const Icon(
                  Icons.check_circle,
                  color: AppPallete.primaryColor,
                ),
                Text(
                  'attendance sucessfully marked'.toUpperCase(),
                  style: AppTextstyle.bodyTextStyle,
                ),
              ],
            )
          ],
        ),
      );

  Widget get staffWidget => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpaceMedium,
          Image.asset(AppImage.qrImage),
          verticalSpaceMedium,
          TextContainer(
            width: 280,
            textColor: AppPallete.black,
            color: AppPallete.transparent,
            border: Border.all(color: AppPallete.black),
            text: 'scan to mark attendance',
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
