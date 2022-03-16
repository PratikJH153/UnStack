import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget dateTextField({
  required BuildContext context,
  required String title,
  required TextEditingController controller,
  required Function onTap,
  required DateTime? time,
}) {
  return Container(
    decoration: containerDecoration,
    child: TextField(
      controller: controller,
      readOnly: true,
      onTap: () async {
        final dateTime = DateTime.now();
        final pickedDate = await showDatePicker(
          context: context,
          initialDate: time!,
          firstDate: DateTime(dateTime.year),
          lastDate: DateTime(dateTime.year + 5),
        );
        onTap(pickedDate);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 13),
        prefixIcon: const Icon(
          CupertinoIcons.calendar,
          color: Colors.white,
        ),
        border: InputBorder.none,
        hintText: title,
        hintStyle: kHintTextFieldTextStyle,
      ),
    ),
  );
}
