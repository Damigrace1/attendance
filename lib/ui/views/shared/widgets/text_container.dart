import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_decoration.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';

class TextContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final BoxBorder? border;
  const TextContainer({
    super.key,
    this.color = AppPallete.darkPurpleColor,
    required this.text,
    this.height,
    this.width,
    this.border,
    this.textColor,
  });

  final Color color;
  final Color? textColor;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.h,
      width: width ?? 230.w,
      alignment: Alignment.center,
      decoration:
          AppDecoration.buttonDecor.copyWith(color: color, border: border),
      child: Text(
        text.toUpperCase(),
        style: AppTextstyle.buttonTextStyle.copyWith(color: textColor),
      ),
    );
  }
}
