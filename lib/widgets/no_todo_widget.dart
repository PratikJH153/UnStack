import 'package:flutter/material.dart';

import 'constants.dart';

class NoTodoWidget extends StatelessWidget {
  final double? height;
  final String? title;
  final String? image;

  NoTodoWidget({
    this.height,
    this.title,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        margin: EdgeInsets.only(
          bottom: height! * 0.16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(image!),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5.0,
                vertical: 20,
              ),
              child: Text(
                title!,
                textAlign: TextAlign.center,
                style: kTextFieldHintTextStyle.copyWith(
                  height: 1.5,
                  wordSpacing: 1.5,
                  letterSpacing: 1.1,
                  color: Colors.white.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
