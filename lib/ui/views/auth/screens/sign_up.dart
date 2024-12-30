import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/validators.dart';
import 'package:qr_attendance_system/models/auth/user.dart';
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

  static final TextEditingController idController = TextEditingController();
  static final TextEditingController emailController = TextEditingController();
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController passwordController = TextEditingController();
 static  final TextEditingController departmentController = TextEditingController();
 static  final TextEditingController levelController = TextEditingController();

 static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget builder(
    BuildContext context,
    AuthViewModel viewModel,
    Widget? child,
  ) {
    return BaseScaffold(
      backgroundColor: color,
      resize: false,
      bodyColor: AppPallete.backgroundColor,
      bodychild: LayoutBuilder(builder: (context, constraints) {
        return Column(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              //Listview will for the containers to take up all width. Do not use.
              child:
              IgnorePointer(
                ignoring: viewModel.isBusy,
                child: Form(
                  key: formKey,
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
                          validator: (v) => Validator.validateEmpty(v),
                          controller: idController,
                          hintText: text == 'staff'
                              ? 'ENTER STAFF ID'
                              : 'eNter matric no',
                        ),
                         CustomTextfield(
                           validator: (v) => Validator.validateEmail(v),
                           controller: emailController,
                          hintText: 'ENTER EMAIL',
                        ),
                        CustomTextfield(
                          validator: (v) => Validator.validateEmpty(v),
                          controller: nameController,
                          hintText: 'ENTER YOUR NAME',
                        ),
                         CustomTextfield(
                           validator: (v) => Validator.validateEmpty(v),
                           controller: departmentController,
                          hintText: 'ENTER DEPARTMENT',
                        ),
                        if (text != 'staff')
                           CustomTextfield(
                             validator: (v) => Validator.validateEmpty(v),
                             controller: levelController,
                            keyboardType: TextInputType.number,
                            maxLength: 3,
                            formatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            hintText: 'ENTER LEVEL',
                          ),
                         CustomTextfield(
                           validator: (v) => Validator.validatePassword(v),
                           textInputAction: TextInputAction.done,
                          autoCapitalize: false,
                          controller: passwordController,
                          hintText: 'enter password',
                        ),
                        verticalSpaceSmall,
                        GeneralButton(
                          text: 'sign up',
                          busy: viewModel.isBusy,
                          buttonColor: buttonColor,
                          onTap: () {
                            if(!formKey.currentState!.validate()){
                              return;
                            }
                            UserModel u = UserModel(
                              email: emailController.text.toLowerCase(),
                              department: departmentController.text,
                              staffId: text == 'staff' ?  idController.text : null ,
                              userType: text,
                              name: nameController.text,
                              password: passwordController.text.toLowerCase(),
                              studentId: text != 'staff' ?  idController.text : null ,
                              level: text == 'staff' ? null : levelController.text,
                            );
                            viewModel.createUser(
                              context,u
                            );

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
