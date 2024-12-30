import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool?> showConfirmationDialog({
  required BuildContext context,
  String title = 'Confirm',
  String content = 'Are you sure?',
  String confirmButtonText = 'Yes',
  String cancelButtonText = 'No',
}) {
  return showDialog<bool>(
    context: context,
    barrierDismissible: false, // User must tap button to dismiss
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(cancelButtonText),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false when canceling
            },
          ),
          TextButton(
            child: Text(confirmButtonText),
            onPressed: () {
              Navigator.of(context).pop(true); // Return true when confirming
            },
          ),
        ],
      );
    },
  );
}