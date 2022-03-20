import 'package:dailytodo/helper/todo_data.dart';
import 'package:dailytodo/views/add_todo_page.dart';
import 'package:dailytodo/views/todo_list.dart';
import 'package:dailytodo/widgets/alert_dialog.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/floatingactionButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatelessWidget {
  static const id = '/todoListPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AddTodoPage.id),
          backgroundColor: Colors.grey[900],
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    iconSize: 25,
                    icon: const Icon(CupertinoIcons.arrow_turn_up_left),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 12.0,
                      bottom: 25,
                    ),
                    child: Text(
                      "Your Todo's",
                      style: kTextFieldHintTextStyle,
                    ),
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return alertDialog(
                            context: context,
                            isYes: () async {
                              Provider.of<TodoData>(context, listen: false)
                                  .clearData();
                              Navigator.pop(context);
                            },
                            title: "Todos",
                          );
                        },
                      );
                    },
                    child: Text("Clear all"),
                    style: TextButton.styleFrom(
                      primary: Colors.red[400],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(style: kHintTextFieldTextStyle, children: [
                  TextSpan(
                    text: "You have ",
                  ),
                  TextSpan(
                      text:
                          "${Provider.of<TodoData>(context).completedTasks}/${Provider.of<TodoData>(context).todoCount}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Ubuntu',
                        fontSize: 20,
                        letterSpacing: 2,
                      )),
                  TextSpan(
                    text: " Tasks left",
                  ),
                ]),
              ),
              LinearPercentIndicator(
                backgroundColor: kprimaryColor,
                linearGradient: LinearGradient(colors: const [
                  const Color(0xFF4797ff),
                  const Color(0xFF643dff),
                  const Color(0xFFff7092),
                  const Color(0xFFf5426c),
                ]),
                percent: Provider.of<TodoData>(context).percentage != double.nan
                    ? Provider.of<TodoData>(context).percentage
                    : 0.0,
                lineHeight: 2,
                animation: true,
                animateFromLastPercent: true,
                animationDuration: 1500,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 15,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: TodoList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
