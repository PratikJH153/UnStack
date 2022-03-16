import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Container appBar({
  BuildContext? context,
  required String title,
  Function? func,
}) {
  return Container(
    child: Row(
      children: [
        IconButton(
          iconSize: 25,
          icon: Icon(CupertinoIcons.arrow_turn_up_left),
          onPressed: () => Navigator.pop(context!),
        ),
        Text(
          title,
          style: kTextFieldHintTextStyle,
        ),
        Spacer(),
        IconButton(
          iconSize: 30,
          icon: Icon(CupertinoIcons.checkmark_alt),
          onPressed: func as void Function()?,
        )
      ],
    ),
  );
}
