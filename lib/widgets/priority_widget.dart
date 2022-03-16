import 'package:dailytodo/widgets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget priorityWidget({
  Color? color,
  required String title,
  Function? onTap,
}) {
  return GestureDetector(
    onTap: onTap as void Function()?,
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      margin: onTap != null ? const EdgeInsets.only(right: 14) : null,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.flag_fill,
            size: 14,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
    ),
  );
}

Widget dayWidget({
  required String title,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
    child: Text(
      title,
      style: kTextFieldHintTextStyle.copyWith(
        color: Colors.grey[800],
        fontFamily: 'Ubuntu',
        fontSize: 18,
      ),
    ),
  );
}
