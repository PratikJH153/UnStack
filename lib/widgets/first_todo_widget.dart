import 'package:dailytodo/models/todo.dart';
import 'package:dailytodo/widgets/confirmation_slider.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/priority_widget.dart';
import 'package:flutter/material.dart';

class FirstTodoWidget extends StatelessWidget {
  final Function? onConfirmed;
  final Todo? todo;

  FirstTodoWidget({
    this.onConfirmed,
    this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      padding: const EdgeInsets.only(
        left: 40,
        top: 20,
        right: 30,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   colors: [
        //     Color(0xFF6e9fff),
        //     Color(0xFF2b5dff),
        //   ],
        // ),
        gradient: new LinearGradient(
          stops: [0.05, 0.015],
          colors: [
            priorities[todo!.priority],
            kprimaryColor,
          ],
        ),
        borderRadius: BorderRadius.circular(40),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Padding(
          //   padding: const EdgeInsets.only(
          //     top: 10.0,
          //     bottom: 20,
          //   ),
          //   child: priorityWidget(
          //     color: priorities[todo!.priority],
          //     title: todo!.priority!,
          //   ),
          // ),
          Text(
            todo!.title!,
            textAlign: TextAlign.center,
            style: kTextFieldHintTextStyle.copyWith(
              height: 1.5,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30.0,
              bottom: 10,
            ),
            child: confirmationSlider(
              height: 55,
              onConfirmed: onConfirmed!,
            ),
          ),
        ],
      ),
    );
  }
}
