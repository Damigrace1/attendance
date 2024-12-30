import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_attendance_system/ui/views/class_attendance/class_attendance_viewmodel.dart';

import 'app_colors.dart';

class TimeBox extends StatelessWidget {
  const TimeBox(
      {super.key,
        required this.currentController,
        required this.currentFocus,
        required this.nextFocus,
        required this.previousFocus,
        required this.onchanged,
        this.width,
        required this.hint, this.validator});

  final TextEditingController currentController;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final FocusNode previousFocus;
  final String hint;
  final Function(String v) onchanged;
  final String? Function(String? v)? validator;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Expanded(

      child: TextFormField(
        controller: currentController,
        focusNode: currentFocus,
        validator: validator,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        style: const TextStyle(fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 2,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintText: hint,
        ),
        onChanged: (value) {
          if (value.isEmpty && currentFocus.hasFocus) {
            previousFocus.requestFocus();
          }
          onchanged(value);
        },
      ),
    );
  }
}