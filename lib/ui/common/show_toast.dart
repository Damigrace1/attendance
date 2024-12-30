import 'package:flutter/material.dart';

void showToast(BuildContext context, String message, {Duration? duration = const Duration(seconds: 2)}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: duration ?? Duration(seconds: 4),
//       action: SnackBarAction(
//         label: 'OK',
//         onPressed: () {
// Navigator.pop(context);
//         },
//       ),
    ),
  );
}
