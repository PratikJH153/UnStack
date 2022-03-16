import 'package:flutter/material.dart';

import 'constants.dart';

Widget tapButton({
  required BuildContext context,
  required Function function,
}) {
  return GestureDetector(
    onTap: function as void Function()?,
    child: Container(
      width: getWidth(context),
      margin: EdgeInsets.only(top: getHeight(context) * 0.6),
      padding: const EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
        color: kaccentColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.done),
          SizedBox(
            width: 6,
          ),
          Text(
            "Create",
            style: kIntroTextStyle.copyWith(
              fontSize: 18,
            ),
          ),
        ],
      ),
    ),
  );
}
