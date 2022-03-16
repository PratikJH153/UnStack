import 'package:flutter/material.dart';

SizedBox floatingActionButton({
  required BuildContext context,
  required var location,
  required IconData icon,
  required Color? backgroundColor,
}) {
  return SizedBox(
    height: 60,
    width: 60,
    child: FloatingActionButton(
      onPressed: () => Navigator.pushNamed(context, location),
      backgroundColor: backgroundColor,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    ),
  );
}
