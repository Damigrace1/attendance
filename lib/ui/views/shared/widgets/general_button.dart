import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'text_container.dart';

class GeneralButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final double width;
  final bool busy;
  final VoidCallback? onTap;
  const GeneralButton({
    super.key,
    required this.buttonColor,
    required this.text,
    this.busy = false,
    this.width = 230,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:  busy ? SizedBox(height: 20.w,width: 20.w,child: const CircularProgressIndicator.adaptive(),) :
      TextContainer(
        color: buttonColor,
        text: text,
        width: width,
      ),
    );
  }
}
