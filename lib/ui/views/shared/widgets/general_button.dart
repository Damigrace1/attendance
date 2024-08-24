import 'package:flutter/material.dart';
import 'text_container.dart';

class GeneralButton extends StatelessWidget {
  final Color buttonColor;
  final String text;
  final double width;
  final VoidCallback? onTap;
  const GeneralButton({
    super.key,
    required this.buttonColor,
    required this.text,
    this.width = 230,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextContainer(
        color: buttonColor,
        text: text,
        width: width,
      ),
    );
  }
}
