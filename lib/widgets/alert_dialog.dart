import 'package:flutter/material.dart';

AlertDialog alertDialog({
  BuildContext? context,
  required String title,
  Function? isYes,
}) {
  return AlertDialog(
    backgroundColor: Colors.grey[900],
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    title: Text(title),
    content: Text(
      "Are you sure to reset every $title?",
      style: const TextStyle(
        color: Color(0xFFBDBDBD),
        fontWeight: FontWeight.w400,
        height: 1.5,
        fontSize: 16,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => isYes!(),
        child: Text(
          "Yes",
          style: const TextStyle(
            color: Color(0xFFEF5350),
          ),
        ),
      ),
      TextButton(
        onPressed: () {
          return Navigator.pop(context!);
        },
        child: Text("No"),
      ),
    ],
  );
}
