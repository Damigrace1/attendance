import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  const CustomTextfield({
    super.key,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: controller,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            isCollapsed: true,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            filled: true,
            fillColor: AppPallete.lightGrey,
            hintText: hintText?.toUpperCase(),
            hintStyle: AppTextstyle.textFieldTextStyle,
          ),
        ),
        verticalSpaceSmall
      ],
    );
  }
}
