import 'package:flutter/material.dart';

SnackBar snackBarWidget({
  required String title,
  Color? color,
}) {
  return SnackBar(
    content: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
      ),
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 4),
    elevation: 1,
  );
}
