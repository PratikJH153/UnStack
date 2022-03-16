import 'package:flutter/material.dart';

Widget backButton(BuildContext context) {
  return TextButton(
    style: TextButton.styleFrom(
      onSurface: Colors.white,
      primary: Colors.grey[600],
    ),
    onPressed: () => Navigator.pop(context),
    child: const Text(
      "Back",
      style: TextStyle(
        fontSize: 16,
      ),
    ),
  );
}
