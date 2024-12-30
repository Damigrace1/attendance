import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';
import 'package:qr_attendance_system/models/auth/user.dart';
import 'package:qr_attendance_system/ui/views/profile/profile_viewmodel.dart';

import '../../../../services/firebase_services.dart';

class ProfileTile extends StatelessWidget {
  final String text;
  const ProfileTile({
    super.key,
    required this.text, required this.viewModel,
  });
final ProfileViewModel viewModel;
 static UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    if(userModel == null) {
      Future.delayed(Duration.zero,() async {
        userModel = await viewModel.getUser();
      });
    }
    return
    viewModel.isBusy ? Center(child: SizedBox(height: 20,width: 20,
    child: CircularProgressIndicator.adaptive(strokeWidth: 2,),),) :
      Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        InkWell(
          onTap: (){
            viewModel.expandProfile(!viewModel.profileInfoExpanded);
          },
          child: Padding(

            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text.toUpperCase(),
                  style: AppTextstyle.labelTextStyleLarge.copyWith(
                    color: AppPallete.backgroundColor,
                  ),
                ),
                AnimatedRotation(turns: viewModel.profileInfoExpanded ? 0.5  : 0,
                  duration: Duration(
                  milliseconds: 200,
                ),
                  child: Icon(
                  Icons.keyboard_arrow_down_rounded,color: Colors.white,
                ),)
              ],
            ),
          ),
        ),
        if(viewModel.profileInfoExpanded && userModel != null)
          Column(
            children: [
              infoRow('EMAIL', userModel!.email!),
              infoRow('ID',userModel!.userType == 'staff' ?  userModel!.staffId! : userModel!.studentId!),
              if(userModel!.userType != 'staff')
                infoRow('LEVEL', userModel!.level!),
              infoRow('DEPARTMENT', userModel!.department!),
            ],
          ),
        const Divider(
          color: AppPallete.backgroundColor,
        ),

      ],
    );
  }
}

Widget infoRow(String key, String value){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 18.w,vertical: 9.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(key,style: AppTextstyle.bodyTextStyleMedium.copyWith(color: Colors.white),),
        Text(value,style: AppTextstyle.bodyTextStyleMedium.copyWith(color: Colors.white)),
      ],
    ),
  );

}