import 'package:flutter/material.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

Widget confirmationSlider({
  required Function onConfirmed,
  required double height,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(100),
    child: ConfirmationSlider(
      onConfirmation: onConfirmed as void Function(),
      foregroundColor: Color.fromARGB(255, 121, 89, 250),
      text: "Slide to Finish",
      textStyle: const TextStyle(
        color: Color(0xFF616161),
        fontWeight: FontWeight.w600,
      ),
      shadow: const BoxShadow(
        blurRadius: 5,
        spreadRadius: 0.5,
        color: Colors.black26,
      ),
      backgroundColor: Color.fromARGB(255, 29, 29, 29),
      height: height,
    ),
  );
}
