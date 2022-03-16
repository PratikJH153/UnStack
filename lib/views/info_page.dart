import 'package:dailytodo/views/info_slider.dart';
import 'package:dailytodo/widgets/bottom_button.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  static const id = "/infoPage";
  final bool isInfo;

  InfoPage({this.isInfo = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: Text(
                "UnStack",
                style: kIntroTextStyle.copyWith(fontSize: 26),
              ),
            ),
            InfoSlider(),
            Spacer(),
            BottomButton(
              isJustInfo: isInfo,
            ),
          ],
        ),
      ),
    );
  }
}
