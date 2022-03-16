import 'package:dailytodo/models/todo.dart';
import 'package:dailytodo/widgets/first_todo_widget.dart';
import 'package:flutter/material.dart';

class DummyTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FirstTodoWidget(
      onConfirmed: () {},
      todo: Todo(
        priority: "Easy",
        status: 0,
        title: "🎉 Congratulations 🎉 \nAdd More Tasks to Grow!",
      ),
    );
  }
}
