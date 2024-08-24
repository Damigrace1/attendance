import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:stacked/stacked.dart';

import '../profile_viewmodel.dart';
import '../widgets/profile_tile.dart';

class ProfileView extends StackedView<ProfileViewModel> {
  static route({required Color color}) => MaterialPageRoute(
        builder: (context) => ProfileView(color: color),
      );
  final Color color;
  const ProfileView({
    Key? key,
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
