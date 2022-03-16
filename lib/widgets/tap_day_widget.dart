import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TapDayWidget extends StatelessWidget {
  final String? value;
  final int? index;
  final Function? doneFunc;

  TapDayWidget({
    this.value,
    this.index,
    this.doneFunc,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: doneFunc as void Function()?,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: value == "null"
              ? Color(0xFF151517)
              : value == "true"
                  ? Colors.green[400]
                  : Colors.red[400],
          border: Border.all(
            color: value == "null"
                ? Colors.grey[900]!
                : value == "true"
                    ? Colors.green[400]!
                    : Colors.red[400]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: value == "null"
            ? Text("$index")
            : value == "true"
                ? Icon(CupertinoIcons.checkmark_alt)
                : Icon(CupertinoIcons.clear),
      ),
    );
  }
}
