import 'package:dailytodo/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget nextButton(Function function) {
  return ElevatedButton.icon(
    style: ElevatedButton.styleFrom(
      primary: kaccentColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 40,
        vertical: 15,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      textStyle: const TextStyle(
        fontSize: 15,
      ),
    ),
    onPressed: function as void Function()?,
    icon: const Text("Next"),
    label: const Icon(
      CupertinoIcons.arrow_right,
      size: 15,
    ),
  );
}
