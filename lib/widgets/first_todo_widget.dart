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
      padding: const EdgeInsets.all(15),
      decoration: containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              bottom: 20,
            ),
            child: priorityWidget(
              color: priorities[todo!.priority],
              title: todo!.priority!,
            ),
          ),
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
              top: 40.0,
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
