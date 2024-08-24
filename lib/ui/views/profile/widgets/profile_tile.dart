import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';
import 'package:qr_attendance_system/core/theme/app_textstyle.dart';

class ProfileTile extends StatelessWidget {
  final String text;
  const ProfileTile({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            text.toUpperCase(),
            style: AppTextstyle.labelTextStyleLarge.copyWith(
              color: AppPallete.backgroundColor,
            ),
          ),
        ),
        const Divider(
          color: AppPallete.backgroundColor,
        ),
      ],
    );
  }
}
