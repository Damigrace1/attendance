import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/app_colors.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/common/validators.dart';

import '../../core/theme/app_pallete.dart';
import '../views/class_attendance/class_attendance_viewmodel.dart';
import 'date_box.dart';

class DateInputRow extends StatefulWidget {
  const DateInputRow({super.key});

  @override
  _DateInputRowState createState() => _DateInputRowState();
}

class _DateInputRowState extends State<DateInputRow> {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  final FocusNode dayFocus = FocusNode();
  final FocusNode monthFocus = FocusNode();
  final FocusNode yearFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add listeners to handle focus movement
    dayController.addListener(() {
      if (dayController.text.length == 2 && dayFocus.hasFocus) {
        monthFocus.requestFocus();
      }
    });

    monthController.addListener(() {
      if (monthController.text.length == 2 && monthFocus.hasFocus) {
        yearFocus.requestFocus();
      }
    });

    yearController.addListener(() {
      if (yearController.text.length == 4) {
        yearFocus.unfocus(); // Or move to the next field if available
      }
    });
  }

  @override
  void dispose() {
    dayController.dispose();
    monthController.dispose();
    yearController.dispose();
    dayFocus.dispose();
    monthFocus.dispose();
    yearFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.lightGrey,
      alignment: Alignment.center,
      padding:  EdgeInsets.symmetric(horizontal: 18.w,vertical: 9.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Day TextField
          Text(
            'DATE',
            style: AppTextstyle.bodyTextStyle,
          ),
          horizontalSpaceMedium,

          Expanded(
            child: Container(
              height: 35.h,
              child: Row(
                children: [
                  Text(
                    'DD',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                  SizedBox(width: 6.w),
                  DateBox(
                      currentController: dayController,
                      currentFocus: dayFocus,
                      previousFocus: dayFocus,
                      onchanged: (v){
                        if(v.isEmpty)return;
                        final d = startTime.copyWith(day: int.parse(v) );
                        startTime = d;
                      },
                      maxLen: 2,
                      hint: '',
                      nextFocus: monthFocus),
                  SizedBox(width: 6.w),
                  Text(
                    'MM',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                  SizedBox(width: 6.w),
                  DateBox(
                      currentController: monthController,
                      currentFocus: monthFocus,
                      previousFocus: dayFocus,
                      maxLen: 2,
                      hint: '',
                      onchanged: (v){
                        if(v.isEmpty)return;
                        final d = startTime.copyWith(month: int.parse(v) );
                        startTime = d;
                      },
                      nextFocus: yearFocus),
                  SizedBox(width: 6.w),
                  Text(
                    'YYYY',
                    style: AppTextstyle.bodyTextStyle,
                  ),
                  SizedBox(width: 6.w),
                  DateBox(
                      currentController: yearController,
                      currentFocus: yearFocus,
                      previousFocus: monthFocus,
                      maxLen: 4,
                      hint: '',
                      onchanged: (v){
                        if(v.isEmpty)return;
                        final d = startTime.copyWith(year: int.parse(v) );
                        startTime = d;
                      },
                      nextFocus: yearFocus),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}


