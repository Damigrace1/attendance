import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/models/class_attendance/attendance.dart';
import 'package:qr_attendance_system/models/class_attendance/lecture.dart';
import 'package:qr_attendance_system/services/firebase_services.dart';
import 'package:qr_attendance_system/ui/common/formatter.dart';

import '../../../common/ui_helpers.dart';

class AllAttendedStudents extends StatelessWidget {
  const AllAttendedStudents({Key? key, required this.lectureId}) : super(key: key);

  final String lectureId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Signed-In Students'),
      ),
      body: FutureBuilder<List<Attendance>>(
        future: FirestoreService().getAttendanceList(lectureId),
        builder: (BuildContext context, AsyncSnapshot<List<Attendance>> snapshot) {
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
            final attendance = snapshot.data;
           if(attendance!.isEmpty){
             return  Center(child: Text('No student has signed in yet',
             style: AppTextstyle.bodyTextStyle,),);
           }
          else {
             return ListView.separated(
                  padding:  EdgeInsets.only(top: 25.h,left: 24.w,right: 24.w),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context,index){
                     Attendance att  = attendance[index];
                    return   ListTile(
                      tileColor: AppPallete.lightGrey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 14.w),
                      title: Text(att.studentName,style: AppTextstyle.bodyTextStyleMedium,),
                      subtitle: Text(att.studentId,style: AppTextstyle.bodyTextStyleMedium,),
                      trailing: Text(SFormatter.formatDate(att.timestamp.toDate()),
                        style: AppTextstyle.bodyTextStyleMedium,),
                    );
                  },
                  shrinkWrap: true,
                  separatorBuilder: (context,__){
                    return  Divider();
                  }, itemCount: attendance.length);
           }
          }
          else {
            return Center(child:SizedBox(height: 20,width: 20.w,child: CircularProgressIndicator.adaptive(strokeWidth: 2,),)
              ,);
          }
        },),
    );
  }
}
