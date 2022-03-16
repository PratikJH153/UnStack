import 'package:dailytodo/views/ask_name_page.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final bool? isJustInfo;

  BottomButton({this.isJustInfo});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 50,
        left: 40,
        right: 40,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: kaccentColor,
      ),
      child: GestureDetector(
        onTap: () => isJustInfo!
            ? Navigator.pop(context)
            : Navigator.pushNamed(context, AskNamePage.id),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: kaccentColor,
          ),
          child: Text(
            "Tap to Continue",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
