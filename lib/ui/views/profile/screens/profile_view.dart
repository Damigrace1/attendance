import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/class_attendance_view.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/mark_attendance_qr.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:stacked/stacked.dart';

import '../profile_viewmodel.dart';
import '../widgets/profile_tile.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  static route({required String text, required Color color}) =>
      MaterialPageRoute(
        builder: (context) => ProfileView(
          color: color,
          text: text,
        ),
      );
  final String text;
  final Color color;
  const ProfileView({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ProfileViewModel viewModel,
    Widget? child,
  ) {
    return BaseScaffold(
      curvedContainerColor: color,
      appBarColor: AppPallete.backgroundColor,
      backgroundColor: color,
      padding: EdgeInsets.zero,
      appBarchild: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  if (text == 'staff') {
                    Navigator.push(
                        context,
                        MarkAttendanceQr.route(
                          text: text,
                          color: color,
                        ));
                  } else {
                    Navigator.push(
                        context,
                        ClassAttendanceView.route(
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
      bodychild: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row forces the container to take full width
          Row(),
          verticalSpaceLarge,
          Divider(
            color: AppPallete.backgroundColor,
          ),
          ProfileTile(text: 'PROFILE info'),
          ProfileTile(text: 'HISTORY'),
        ],
      ),
    );
  }

  @override
  ProfileViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ProfileViewModel();
}
