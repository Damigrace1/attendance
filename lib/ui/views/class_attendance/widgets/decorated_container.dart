import 'package:flutter/material.dart';
import 'package:qr_attendance_system/core/theme/app_decoration.dart';
import 'package:qr_attendance_system/core/theme/app_pallete.dart';

class DecorContainerRow extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  const DecorContainerRow(
      {super.key,
      required this.children,
      this.crossAxisAlignment = CrossAxisAlignment.center});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      decoration: AppDecoration.buttonDecor.copyWith(
        color: AppPallete.lightGrey,
      ),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }
}
