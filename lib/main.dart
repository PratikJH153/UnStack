import 'package:dailytodo/views/add_challenge_page.dart';
import 'package:dailytodo/views/add_planned_goals_page.dart';
import 'package:dailytodo/views/add_timeline_page.dart';
import 'package:dailytodo/views/add_todo_page.dart';
import 'package:dailytodo/views/ask_name_page.dart';
import 'package:dailytodo/views/home.dart';
import 'package:dailytodo/views/info_page.dart';
import 'package:dailytodo/views/plan_goals_page.dart';
import 'package:dailytodo/views/todo_list_page.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'helper/todo_data.dart';

void main() {
  Paint.enableDithering = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TodoData>(
      create: (context) => TodoData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Stacked",
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF151517),
          primaryColor: const Color(0xFF212024),
          canvasColor: const Color(0xFFfe7551),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.white,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: Wrapper.id,
        routes: {
          Wrapper.id: (context) => Wrapper(),
          HomePage.id: (context) => HomePage(),
          InfoPage.id: (context) => InfoPage(),
          AskNamePage.id: (context) => AskNamePage(),
          TodoListPage.id: (context) => TodoListPage(),
          AddTodoPage.id: (context) => AddTodoPage(),
          AddChallengePage.id: (context) => AddChallengePage(),
          AddTimeLinePage.id: (context) => AddTimeLinePage(),
          AddPlannedGoalsPage.id: (context) => AddPlannedGoalsPage(),
          PlanGoalsPage.id: (context) => PlanGoalsPage(),
        },
      ),
    );
  }
}
