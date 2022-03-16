import 'package:flutter/material.dart';

import 'constants.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? textEditingController;
  final String? hintText;
  final bool isDes;

  TextFieldWidget({
    this.textEditingController,
    this.hintText,
    this.isDes = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      maxLines: isDes ? null : 1,
      keyboardType: TextInputType.text,
      autocorrect: true,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 12),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: kHintTextFieldTextStyle,
      ),
      controller: textEditingController,
    );
  }
}
