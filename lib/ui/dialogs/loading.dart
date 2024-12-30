


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomDialog(BuildContext context,String message){
  showDialog(context: context, builder: (context)=>
      Center(
        child: Card(
          color: Colors.white,
          child: Container(
            width: 100,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20,height: 20,
                  child: CircularProgressIndicator.adaptive(strokeWidth: 2,
                  ),),
                SizedBox(height: 10.h,),
                Text(message,
                  style: TextStyle(fontWeight: FontWeight.w600),)
              ],
            ),
          ),
        ),
      )
  );
}