import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/todo.dart';
import 'package:dailytodo/helper/todo_data.dart';
import 'package:dailytodo/views/todo_list_page.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:dailytodo/widgets/app_bar.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/floatingactionButton.dart';
import 'package:dailytodo/widgets/priority_widget.dart';
import 'package:dailytodo/widgets/snackbar_widget.dart';
import 'package:dailytodo/widgets/textFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTodoPage extends StatefulWidget {
  static const id = '/addTodoPage';
  final Todo? todo;

  AddTodoPage({this.todo});

  @override
  _AddTodoPageState createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  String? _priority = "Easy";

  TextEditingController _titleController = TextEditingController();

  _submit() async {
    if (_titleController.text.trim().isNotEmpty &&
        _titleController.text.trim().length > 1) {
      if (widget.todo == null) {
        Todo todo = Todo(
          title: _titleController.text.trim(),
          priority: _priority,
        );
        todo.status = 0;
        await DatabaseService.instance.insertTodo(todo).then((value) async {
          Provider.of<TodoData>(context, listen: false)
              .addTodo(todo, value); //Todo(id:null, title:jkhsadfkjds)
        }); //Todo(title:jkhsadfkjds)

      } else {
        widget.todo!.title = _titleController.text.trim();
        widget.todo!.priority = _priority;

        Provider.of<TodoData>(context, listen: false).updateTodo(widget.todo!);
        await DatabaseService.instance.updateTodo(widget.todo!);
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Wrapper.id, (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(
          title: "Please enter a valid title",
          color: Colors.red[400],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _priority = widget.todo!.priority;
      _titleController.text = widget.todo!.title!;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(
        backgroundColor: Colors.grey[900],
        context: context,
        icon: CupertinoIcons.line_horizontal_3_decrease,
        location: TodoListPage.id,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(
                  context: context,
                  func: _submit,
                  title: "Add your Todo",
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Row(
                    children: priorities.entries
                        .map(
                          (entry) => priorityWidget(
                            color: entry.key == _priority
                                ? entry.value
                                : Colors.white.withOpacity(0.1),
                            title: entry.key,
                            onTap: () {
                              setState(
                                () {
                                  _priority = entry.key;
                                },
                              );
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  decoration: containerDecoration,
                  child: TextFieldWidget(
                    hintText: "Enter the task",
                    textEditingController: _titleController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
