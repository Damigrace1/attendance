import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/input_formatter.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool autoCapitalize;
  final List<TextInputFormatter>? formatters;

  const CustomTextfield({
    super.key,
    this.controller,this.autoCapitalize = true,
    this.hintText, this.textInputAction, this.validator, this.keyboardType, this.formatters, this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          keyboardType: keyboardType,
          textInputAction: textInputAction ?? TextInputAction.next,
          controller: controller,
          textAlign: TextAlign.center,
          style: AppTextstyle.textFieldTextStyle,
          validator: validator,
          maxLength:maxLength ,

          inputFormatters: [
            if(autoCapitalize)
            UpperCaseTextFormatter(),
              ...?formatters
          ],
          decoration: InputDecoration(
            counterText: '',
            labelStyle: AppTextstyle.textFieldHintTextStyle,
            contentPadding:
                 EdgeInsets.symmetric(vertical: 2.h, horizontal: 16.w),
            isCollapsed: true,
            border:  OutlineInputBorder(borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(0)),
           filled: true,
            fillColor: AppPallete.lightGrey,
           hintText: hintText?.toUpperCase(),

          ),
        ),
        verticalSpaceSmall
      ],
    );
  }
}
