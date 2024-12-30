import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_decoration.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/ui/common/app_colors.dart';
import 'package:qr_attendance_system/ui/common/show_toast.dart';
import 'package:qr_attendance_system/ui/common/time_box.dart';
import 'package:qr_attendance_system/ui/common/ui_helpers.dart';
import 'package:qr_attendance_system/ui/common/validators.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/class_attendance_viewmodel.dart';
import 'package:qr_attendance_system/ui/views/shared/widgets/text_container.dart';

import '../../core/theme/app_pallete.dart';

class TimeInputRow extends StatefulWidget {
  const TimeInputRow({super.key});

  @override
  _TimeInputRowState createState() => _TimeInputRowState();
}


DateTime copyWith({
  int? year,
  int? month,
  int? day,
  int? hour,
  int? minute,
  int? second,
  int? millisecond,
  int? microsecond,
}) {
  return DateTime(
    year ?? startTime.year,
    month ?? startTime.month,
    day ?? startTime.day,
    hour ?? startTime.hour,
    minute ?? startTime.minute,
    second ?? startTime.second,
  );
}

class _TimeInputRowState extends State<TimeInputRow> {
  final TextEditingController minCont = TextEditingController();
  final TextEditingController hrCont = TextEditingController();

  final FocusNode minFocus = FocusNode();
  final FocusNode hrFocus = FocusNode();

  @override
  void initState() {
    super.initState();

    // Add listeners to handle focus movement
    minCont.addListener(() {
      if (minCont.text.length == 2 && minFocus.hasFocus) {
        minFocus.unfocus();
      }
    });

    hrCont.addListener(() {
      if (hrCont.text.length == 2 && hrFocus.hasFocus) {
        minFocus.requestFocus();
      }
    });
  }

  @override
  void dispose() {
    minCont.dispose();
    hrCont.dispose();
    minFocus.dispose();
    hrFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppPallete.lightGrey,
      alignment: Alignment.center,
      padding:  EdgeInsets.symmetric(horizontal: 18.w,vertical: 9.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'TIME',
            style: AppTextstyle.bodyTextStyle,
          ),
          Container(
            width: 79.w,
            height: 30.h,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1
              )
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TimeBox(
                    currentController: hrCont,
                    currentFocus: hrFocus,
                    previousFocus: hrFocus,
                    validator: (v){
                     validTime = Validator.validateHour(v);
                     if(!validTime){
                       showToast(context, 'Hour must be between 0 - 24 hours');
                       hrCont.clear();
                     }
                      return null;
                    },
                    hint: '00',
                    onchanged: (v){
                      if(v.isEmpty)return;
                      final d = startTime.copyWith(hour: int.parse(v) );
                      startTime = d;
                    },
                    nextFocus: minFocus),
               Image.asset('assets/images/semi.png',height: 12.h,),
                TimeBox(

                    currentController: minCont,
                    currentFocus: minFocus,
                    previousFocus: hrFocus,
                    onchanged: (v){
                      if(v.isEmpty)return;
                      final d = startTime.copyWith(minute: int.parse(v) );
                      startTime = d;
                    },
                    hint: '00',
                    nextFocus: minFocus),
              ],
            ),
          ),
          const SizedBox(),

        ],
      ),
    );
  }
}



