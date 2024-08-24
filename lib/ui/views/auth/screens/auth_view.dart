import 'package:flutter/material.dart';
import 'package:qr_attendance_system/ui/views/auth/screens/login_in.dart';
import 'package:stacked/stacked.dart';

import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/auth/provider/auth_viewmodel.dart';

class AuthView extends StackedView<AuthViewModel> {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return BaseScaffold(
      backgroundColor: AppPallete.secondaryColor,
      bodyColor: AppPallete.backgroundColor,
      bodychild: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row forces the container to take full width
          const Row(),
          GeneralButton(
            text: 'student',
            buttonColor: AppPallete.darkPurpleColor,
            onTap: () => Navigator.push(
                context,
                LoginIn.route(
                    text: 'Student',
                    color: AppPallete.secondaryColor,
                    buttonColor: AppPallete.primaryColor)),
          ),
          verticalSpaceMedium,
          GeneralButton(
            text: 'staff',
            buttonColor: AppPallete.primaryColor,
            onTap: () => Navigator.push(
                context,
                LoginIn.route(
                    text: 'staff',
                    color: AppPallete.primaryColor,
                    buttonColor: AppPallete.darkPurpleColor)),
          ),
        ],
      ),
    );
  }

  @override
  AuthViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthViewModel();
}
