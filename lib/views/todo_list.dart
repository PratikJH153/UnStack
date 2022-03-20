import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/helper/ad_helper.dart';
import 'package:dailytodo/helper/todo_data.dart';
import 'package:dailytodo/views/add_todo_page.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/no_todo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final DatabaseService _databaseService = DatabaseService.instance;
  final AdmobHelper admobHelper = AdmobHelper();

  @override
  Widget build(BuildContext context) {
    return Provider.of<TodoData>(context).isListEmpty
        ? NoTodoWidget(
            height: getHeight(context),
            image: "assets/images/todolist.png",
            title: "No Todos added yet. Got to get yourself pumped up!",
          )
        : Consumer<TodoData>(
            builder: (context, todoData, child) {
              return Theme(
                data: ThemeData(
                  canvasColor: Colors.transparent.withOpacity(0),
                ),
                child: ReorderableListView.builder(
                  onReorder: (oldIndex, newIndex) {
                    Provider.of<TodoData>(context, listen: false)
                        .updateOrder(oldIndex, newIndex);
                  },
                  padding: const EdgeInsets.only(bottom: 100),
                  shrinkWrap: true,
                  itemCount:
                      Provider.of<TodoData>(context, listen: false).todoCount,
                  itemBuilder: (context, index) {
                    final todo = todoData.getTodo(index);
                    return Slidable(
                      direction: Axis.horizontal,
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          IconButton(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                            ),
                            icon: Icon(
                              CupertinoIcons.pencil_outline,
                              color: Colors.white,
                            ),
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddTodoPage(
                                  todo: todo,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            icon: Icon(
                              CupertinoIcons.delete_simple,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              await _databaseService.deleteTodo(todo.id);
                              Provider.of<TodoData>(context, listen: false)
                                  .deleteTodo(todo);
                              await Provider.of<TodoData>(context,
                                      listen: false)
                                  .getTodoFromDatabase();
                            },
                          ),
                        ],
                      ),
                      key: ValueKey(todo),
                      child: Container(
                        key: ValueKey(todo),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          color: kprimaryColor,
                          borderRadius: BorderRadius.circular(10),
                          gradient: new LinearGradient(stops: [
                            0.015,
                            0.015
                          ], colors: [
                            todo.status == 1
                                ? Colors.grey[700]!
                                : priorities[todo.priority],
                            kprimaryColor
                          ]),
                        ),
                        margin: EdgeInsets.only(top: 15),
                        child: ListTile(
                          key: ValueKey(todo),
                          onTap: () async {
                            todo.status = todo.status == 1 ? 0 : 1;
                            await _databaseService.updateTodo(todo);

                            Provider.of<TodoData>(context, listen: false)
                                .updateTodo(todo);
                            await Provider.of<TodoData>(context, listen: false)
                                .getTodoFromDatabase();
                            if (todoData.completedTasks == 1) {
                              admobHelper.showInterad(() {});
                            } else if (todoData.todoCount ==
                                todoData.completedTasks) {
                              admobHelper.showInterad(() {});
                            }
                          },
                          title: Text(
                            todo.title!,
                            style: kTextFieldHintTextStyle.copyWith(
                              fontSize: 16,
                              color:
                                  todo.status == 1 ? Colors.grey : Colors.white,
                              decoration: todo.status == 1
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          trailing: Icon(
                            Icons.drag_handle_rounded,
                            color:
                                todo.status == 1 ? Colors.grey : Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
  }
}
