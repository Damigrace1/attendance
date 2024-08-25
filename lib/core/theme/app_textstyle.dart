import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_pallete.dart';

class AppTextstyle {
  AppTextstyle._();

  // static TextStyle get profileTextStyle => GoogleFonts.alumniSans();
  static TextStyle get textFieldTextStyle =>
      GoogleFonts.alumniSans(fontSize: 26.sp, color: AppPallete.black);
  static TextStyle get labelTextStyleSmall =>
      GoogleFonts.alumniSans(fontSize: 18.sp, fontWeight: FontWeight.w700);
  static TextStyle get labelTextStyleLarge => GoogleFonts.alumniSans(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppPallete.black,
      );
  static TextStyle get profileTextStyleLarge => GoogleFonts.alumniSans(
        fontSize: 26.sp,
        fontWeight: FontWeight.w700,
        color: AppPallete.black,
      );
  static TextStyle get bodyTextStyle =>
      GoogleFonts.alumniSans(fontSize: 26.sp, fontWeight: FontWeight.w700);
  static TextStyle get splashTextStyle => GoogleFonts.alumniSans(
        fontSize: 96.sp,
        fontWeight: FontWeight.w600,
        color: AppPallete.black,
      );
  static TextStyle get buttonTextStyle => GoogleFonts.alumniSans(
      color: AppPallete.backgroundColor,
      fontSize: 32.sp,
      fontWeight: FontWeight.w600);
  static TextStyle get bodyTextStyleMedium => GoogleFonts.alumniSans(
      fontSize: 16.sp, fontWeight: FontWeight.w600, color: AppPallete.black);
}
