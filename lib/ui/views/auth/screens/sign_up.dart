import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/screens/class_attendance_view.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/custom_textfield.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';
import 'package:stacked/stacked.dart';

import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/basescafold.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/general_button.dart';
import 'package:qr_attendance_system/ui/views/auth/provider/auth_viewmodel.dart';

class SignIn extends StackedView<AuthViewModel> {
  static route(
          {required String text,
          required Color color,
          required Color buttonColor}) =>
      MaterialPageRoute(
        builder: (context) => SignIn(
          text: text,
          color: color,
          buttonColor: buttonColor,
        ),
      );
  final String text;
  final Color color;
  final Color buttonColor;
  const SignIn({
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
      bodychild: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              //Listview will for the containers to take up all width. Do not use.
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextContainer(
                      width: 280.w,
                      color:
                          text == 'staff' ? color : AppPallete.darkPurpleColor,
                      text: '$text sign up',
                    ),
                    verticalSpaceLarge,
                    CustomTextfield(
                      hintText: text == 'staff'
                          ? 'ENTER STAFF ID'
                          : 'eNter matric no',
                    ),
                    const CustomTextfield(
                      hintText: 'ENTER EMAIL OR PHONE NO',
                    ),
                    const CustomTextfield(
                      hintText: 'ENTER DEPARTMENT',
                    ),
                    if (text != 'staff')
                      const CustomTextfield(
                        hintText: 'ENTER LEVEL',
                      ),
                    const CustomTextfield(
                      hintText: 'enter password',
                    ),
                    verticalSpaceSmall,
                    GeneralButton(
                      text: 'sign up',
                      buttonColor: buttonColor,
                      onTap: () {
                        Navigator.push(
                            context,
                            ClassAttendanceView.route(
                              text: text,
                              color: color,
                            ));
                      },
                    ),
                    verticalSpaceMedium,
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text.rich(
                          TextSpan(
                            text: 'ALREADY have an account? '.toUpperCase(),
                            style: AppTextstyle.bodyTextStyleMedium,
                            children: [
                              TextSpan(
                                text: 'SIGN IN',
                                style: AppTextstyle.bodyTextStyleMedium
                                    .copyWith(color: AppPallete.secondaryColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(300.h),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  @override
  AuthViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      AuthViewModel();
}
