import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/views/auth/screens/sign_up.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/class_attendance_view.dart';
import 'package:qr_attendance_system/ui/views/profile/screens/profile_view.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/custom_textfield.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:stacked/stacked.dart';

import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/auth/provider/auth_viewmodel.dart';

import '../../../common/validators.dart';

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

  static final TextEditingController passwordController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();

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
     final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return BaseScaffold(
      backgroundColor: color,
      bodyColor: AppPallete.backgroundColor,
      bodychild: IgnorePointer(
        ignoring: viewModel.isBusy,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              // Row forces the container to take full width
              const Row(),
              TextContainer(
                width: 280.w,
                color: AppPallete.darkPurpleColor,
                text: '$text sign in',
              ),
              verticalSpaceLarge,
               CustomTextfield(
                hintText: 'Email',
                 validator: (v) => Validator.validateEmpty(v),
                controller: emailController,
              ),
               CustomTextfield(
                 autoCapitalize: false,
                hintText: 'password',
                 validator: (v) => Validator.validatePassword(v),
                 controller: passwordController,
              ),
              verticalSpaceSmall,
              GeneralButton(
                text: 'sign in',
                busy: viewModel.isBusy,
                buttonColor: AppPallete.primaryColor,
                onTap: () {
                  if(!formKey.currentState!.validate()){
                    return;
                  }
                 viewModel.signInUser(context, email: emailController.text
                     .toLowerCase(), pw:
                 passwordController.text.toLowerCase());
                },
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
                        text: 'SIGN UP',
                        style: AppTextstyle.bodyTextStyleMedium
                            .copyWith(color: AppPallete.secondaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              verticalSpaceMedium,
            ],
          ),
        ),
      ),
    );
  }

  @override
  AuthViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthViewModel();
}
