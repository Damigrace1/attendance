import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';

class AppDecoration {
  AppDecoration._();
  static BoxDecoration get buttonDecor =>
      BoxDecoration(borderRadius: BorderRadius.circular(8));
  static BoxDecoration get greyDecor =>
      BoxDecoration(color: AppPallete.lightGrey);
  static BoxDecoration get boxDecor =>
      BoxDecoration(border: Border.all(color: AppPallete.black));
  static BoxDecoration get containerTopDecor => const BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)));
  static BoxDecoration get containerBottomDecor => const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
      );
}
