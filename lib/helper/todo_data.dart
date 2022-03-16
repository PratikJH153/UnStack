import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/helper/order_data.dart';
import 'package:dailytodo/models/todo.dart';
import 'package:flutter/cupertino.dart';

class TodoData extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;
  List<Todo>? todoList;

  Todo? firstTodo;
  List<int?> orders = [];

  Future<bool> getTodoFromDatabase() async {
    final List<Todo> completedList = [];
    final List<Todo> tempList = [];
    todoList = [];
    await getOrder();
    List<Todo> result = await _databaseService.getTodoLists();

    result.forEach((todo) {
      if (todo.status == 0) {
        tempList.add(todo);
      } else {
        completedList.add(todo);
      }
    });

    orders.forEach((id) {
      tempList.forEach((element) {
        if (id == element.id) {
          todoList!.add(element);
        }
      });
    });

    todoList!.addAll(completedList);

    if (isCompleted) {
      getTodoData();
    }

    notifyListeners();

    return true;
  }

  void clearData() async {
    todoList!.clear();
    orders.clear();
    updateOder(orders);
    await _databaseService.deleteAll();
    notifyListeners();
  }

  bool get isListEmpty {
    return todoList == null || todoList == [] || todoList!.isEmpty;
  }

  void getTodoData() {
    firstTodo = todoList!.first;
    notifyListeners();
  }

  Todo getTodo(int index) {
    return todoList![index];
  }

  void sortTodo(List<Todo> result) {
    result.sort((todoA, todoB) => todoA.status!.compareTo(todoB.status!));
    notifyListeners();
  }

  void addTodo(Todo todo, int id) {
    todoList!.add(todo);
    orders.add(id);

    updateOder(orders);
    sortTodo(todoList!);
    notifyListeners();
  }

  void deleteTodo(Todo todo) async {
    todoList!.remove(todo);
    await getOrder();
    orders.remove(todo.id);
    updateOder(orders);

    notifyListeners();
  }

  void updateOrder(int oldIndex, int newIndex) async {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final Todo item = todoList!.removeAt(oldIndex);
    todoList!.insert(newIndex, item);
    final int? previousItem = orders.removeAt(oldIndex);
    orders.insert(newIndex, previousItem);
    updateOder(orders);
    notifyListeners();
  }

  void updateOder(List<int?> order) {
    OrderData.setOrder(order.map((e) => e.toString()).toList());
  }

  Future<void> getOrder() async {
    orders = await OrderData.getOrder();
    // print("ORDER WHILE GETORDER CALLED:  $orders");
  }

  void updateTodo(Todo todo) {
    todoList![todoList!.indexWhere((element) => element.id == todo.id)] = todo;
    if (todo.status == 0) {
      if (!orders.contains(todo.id)) {
        orders.add(todo.id);
      }
    } else {
      orders.remove(todo.id);
    }
    updateOder(orders);
    percentage;
    isCompleted;
    sortTodo(todoList!);
    notifyListeners();
  }

  int get completedTasks {
    int completedTask =
        todoList!.where((Todo todo) => todo.status == 1).toList().length;
    return completedTask;
  }

  int get todoCount {
    return todoList!.length;
  }

  double get percentage {
    int ct = completedTasks;
    if (todoCount != 0) {
      double percentage = ct / todoCount;
      return percentage;
    }
    return 0.0;
  }

  bool get isCompleted {
    return percentage >= 0.99;
  }
}
