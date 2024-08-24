import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:qr_attendance_system/core/app_image.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:stacked/stacked.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';

import 'startup_viewmodel.dart';

class StartupView extends StackedView<StartupViewModel> {
  const StartupView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    StartupViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImage.splashImage), fit: BoxFit.fill)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text.rich(
                  TextSpan(
                      text: 'A',
                      style: AppTextstyle.splashTextStyle
                          .copyWith(color: AppPallete.secondaryColor),
                      children: [
                        TextSpan(
                            text: 'M',
                            style: AppTextstyle.splashTextStyle
                                .copyWith(color: AppPallete.primaryColor)),
                        TextSpan(
                            text: 'M',
                            style: AppTextstyle.splashTextStyle
                                .copyWith(color: AppPallete.darkPurpleColor)),
                      ]),
                ),
                verticalSpaceSmall,
                Text('attendance management system'.toUpperCase(),
                    style: AppTextstyle.bodyTextStyle),
                verticalSpaceMedium,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppPallete.secondaryColor,
                    ),
                    horizontalSpaceSmall,
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppPallete.primaryColor,
                    ),
                    horizontalSpaceSmall,
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppPallete.darkPurpleColor,
                    ),
                  ],
                ),
                verticalSpaceMassive,
              ],
            ),
          ),
        );
      }),
    );
  }

  @override
  StartupViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      StartupViewModel();

  @override
  void onViewModelReady(StartupViewModel viewModel) => SchedulerBinding.instance
      .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
