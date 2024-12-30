import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';

class DateBox extends StatelessWidget {
  const DateBox(
      {super.key,
        required this.currentController,
        required this.currentFocus,
        required this.nextFocus,
        required this.previousFocus,
        required this.maxLen,

        this.width,
        required this.hint,
        required this.onchanged, this.validator});

  final String? Function(String? v)? validator;
  final TextEditingController currentController;
  final FocusNode currentFocus;
  final FocusNode nextFocus;
  final FocusNode previousFocus;
  final String hint;
  final int maxLen;
  final double? width;
  final Function(String v) onchanged;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: maxLen,
      child: TextFormField(
        controller: currentController,
        focusNode: currentFocus,
        maxLength: maxLen,
        validator: validator,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly
        ],
        style: const TextStyle(fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          border: const OutlineInputBorder(borderSide: BorderSide(width: 1)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: kcPrimaryColor),
              borderRadius: BorderRadius.all(Radius.circular(0))),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 1),
              borderRadius: BorderRadius.all(Radius.circular(0))),
          counterText: '',
          hintText: hint,
        ),
        onChanged: (value) {
          onchanged(value);
          if (value.isEmpty && currentFocus.hasFocus) {
            previousFocus.requestFocus();

          }
        },
      ),
    );
  }
}