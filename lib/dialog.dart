import 'package:flutter/material.dart';

Future<int?> showAlertDialog(
  BuildContext context,
  String? title,
  String? message, {
  bool barrierDismissible = false,
}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
      return AlertDialog(
        title: Text(title ?? ""),
        content: Text(message ?? ""),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("确定"),
          ),
        ],
      );
    },
  );
}
