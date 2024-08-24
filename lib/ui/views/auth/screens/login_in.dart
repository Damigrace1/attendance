import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/views/auth/screens/sign_in.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/custom_textfield.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:stacked/stacked.dart';

import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/auth/provider/auth_viewmodel.dart';

class LoginIn extends StackedView<AuthViewModel> {
  static route(
          {required String text,
          required Color color,
          required Color buttonColor}) =>
      MaterialPageRoute(
        builder: (context) => LoginIn(
          text: text,
          color: color,
          buttonColor: buttonColor,
        ),
      );
  final String text;
  final Color color;
  final Color buttonColor;
  const LoginIn({
    Key? key,
    required this.text,
    required this.color,
    required this.buttonColor,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return BaseScaffold(
      backgroundColor: color,
      bodyColor: AppPallete.backgroundColor,
      bodychild: Column(
        children: [
          // Row forces the container to take full width
          const Row(),
          TextContainer(
            width: 280,
            color: AppPallete.darkPurpleColor,
            text: '$text sign in',
          ),
          verticalSpaceLarge,
          const CustomTextfield(
            hintText: 'Matric no',
          ),
          const CustomTextfield(
            hintText: 'password',
          ),
          verticalSpaceSmall,
          GeneralButton(
            text: 'sign in',
            buttonColor: AppPallete.primaryColor,
            onTap: () {},
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.push(
                context,
                SignIn.route(
                  text: text,
                  color: color,
                  buttonColor: buttonColor,
                )),
            child: Text.rich(
              TextSpan(
                text: 'Don’t have an account? '.toUpperCase(),
                style: AppTextstyle.bodyTextStyleMedium,
                children: [
                  TextSpan(
                    text: 'SIGN IN',
                    style: AppTextstyle.bodyTextStyleMedium
                        .copyWith(color: buttonColor),
                  ),
                ],
              ),
            ),
          ),
          verticalSpaceMedium,
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
