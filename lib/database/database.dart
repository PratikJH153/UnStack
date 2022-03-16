import 'dart:async';

import 'package:dailytodo/models/challenge.dart';
import 'package:dailytodo/models/day.dart';
import 'package:dailytodo/models/goal.dart';
import 'package:dailytodo/models/timeline.dart';

import '../models/todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._instance();

  DatabaseService._instance();

  static Database? _db;

  String table = 'todo_table';
  String colId = 'id';
  String colTitle = 'title';
  String colPriority = 'priority';
  String colStatus = 'status';

  String timelineTable = 'timeline_table';
  String colDes = 'des';
  String colDay = 'day';
  String colDateTime = 'dateTime';

  String challengeTable = 'challenge_table';
  String colIsDone = 'isDone';
  String colTotalDays = 'totalDays';
  String colCompletedDays = 'completedDays';
  String colDoneDate = 'doneDate';

  String dayTable = 'day_table';
  String colValue = 'value';

  String goalsTable = 'goals_table';
  String colStartDate = 'startDate';
  String colEndDate = 'endDate';

  Future<Database?> get database async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + './todo_list.db';
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colPriority TEXT,$colStatus INTEGER)');
    await db.execute(
        'CREATE TABLE $timelineTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDes TEXT,$colDay INTEGER, $colDateTime TEXT)');
    await db.execute(
        'CREATE TABLE $challengeTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colDes TEXT,$colIsDone INTEGER,$colTotalDays INTEGER,$colCompletedDays INTEGER, $colDoneDate TEXT)');
    await db.execute(
        'CREATE TABLE $dayTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colDay INTEGER, $colValue TEXT)');
    await db.execute(
        'CREATE TABLE $goalsTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colTitle TEXT,$colPriority TEXT,$colStartDate TEXT, $colEndDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getMapLists() async {
    Database? db = await this.database;
    final List<Map<String, dynamic>> result = await db!.query(table);
    return result;
  }

  Future<List<Todo>> getTodoLists() async {
    final List<Map<String, dynamic>> mapLists = await getMapLists();
    final List<Todo> todoLists = [];

    // final order = await OrderData.getOrder();

    mapLists.forEach((todo) {
      todoLists.add(Todo.fromMap(todo));
    });
    return todoLists;
  }

  Future<int> insertTodo(Todo todo) async {
    Database? db = await this.database;

    final int id = await db!.insert(table, todo.toMap());
    return id;
  }

  Future<int> deleteTodo(int? id) async {
    Database? db = await this.database;
    final int result = await db!.delete(
      table,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> updateTodo(Todo todo) async {
    Database? db = await this.database;
    final int result = await db!.update(
      table,
      todo.toMap(),
      where: '$colId = ?',
      whereArgs: [todo.id],
    );
    return result;
  }

  Future<int> deleteAll() async {
    Database? db = await this.database;
    final int result = await db!.delete(table);
    return result;
  }

  Future<List<Map<String, dynamic>>> getTimeMapList() async {
    Database? db = await this.database;
    final List<Map<String, dynamic>> result = await db!.query(timelineTable);
    return result;
  }

  Future<List<Timeline>> getTimeLineList() async {
    final List<Map<String, dynamic>> mapLists = await getTimeMapList();
    final List<Timeline> timeLineLists = [];
    mapLists.forEach((timeline) {
      timeLineLists.add(Timeline.fromMap(timeline));
    });

    return timeLineLists.reversed.toList();
  }

  Future<int> insertTimeLine(Timeline timeline) async {
    Database? db = await this.database;
    final int result = await db!.insert(timelineTable, timeline.toMap());
    return result;
  }

  Future<int> updateTimeline(Timeline timeline) async {
    Database? db = await this.database;
    final int result = await db!.update(
      timelineTable,
      timeline.toMap(),
      where: '$colId = ?',
      whereArgs: [timeline.id],
    );
    return result;
  }

  Future<int> insertChallenge(Challenge challenge) async {
    Database? db = await this.database;

    final int result = await db!.insert(challengeTable, challenge.toMap());
    return result;
  }

  Future<int> deleteChallenge(int? id) async {
    Database? db = await this.database;
    final int result = await db!.delete(
      challengeTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> updateChallenge(Challenge challenge) async {
    Database? db = await this.database;
    final int result = await db!.update(
      challengeTable,
      challenge.toMap(),
      where: '$colId = ?',
      whereArgs: [challenge.id],
    );
    return result;
  }

  Future<int> deleteAllChallenges() async {
    Database? db = await this.database;
    final int result = await db!.delete(challengeTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getChallengeMap() async {
    Database? db = await this.database;
    final List<Map<String, dynamic>> result = await db!.query(challengeTable);
    return result;
  }

  Future<List<Challenge>> getChallengeList() async {
    final List<Map<String, dynamic>> mapLists = await getChallengeMap();
    final List<Challenge> challengeLists = [];
    mapLists.forEach((challenge) {
      challengeLists.add(Challenge.fromMap(challenge));
    });
    challengeLists.sort((challengeA, challengeB) =>
        challengeA.isDone!.compareTo(challengeB.isDone!));
    return challengeLists;
  }

  Future<void> insertDay() async {
    Database? db = await this.database;
    for (int i = 0; i < 100; i++) {
      Day day = Day(
        day: i + 1,
        value: "null",
      );
      await db!.insert(dayTable, day.toMap());
    }
  }

  Future<int> updateDay(Day day) async {
    Database? db = await this.database;
    final int result = await db!.update(
      dayTable,
      day.toMap(),
      where: '$colId = ?',
      whereArgs: [day.id],
    );
    return result;
  }

  Future<int> deleteAllDays() async {
    Database? db = await this.database;
    final int result = await db!.delete(timelineTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getDayMap() async {
    Database? db = await this.database;
    final List<Map<String, dynamic>> result = await db!.query(dayTable);
    return result;
  }

  Future<List<Day>> getDayList() async {
    final List<Map<String, dynamic>> mapLists = await getDayMap();
    final List<Day> dayLists = [];
    mapLists.forEach((day) {
      dayLists.add(Day.fromMap(day));
    });
    return dayLists;
  }

  Future<int> insertGoal(Goal goal) async {
    Database? db = await this.database;

    final int result = await db!.insert(goalsTable, goal.toMap());
    return result;
  }

  Future<int> deleteGoal(int? id) async {
    Database? db = await this.database;
    final int result = await db!.delete(
      goalsTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

  Future<int> updateGoal(Goal goal) async {
    Database? db = await this.database;
    final int result = await db!.update(
      goalsTable,
      goal.toMap(),
      where: '$colId = ?',
      whereArgs: [goal.id],
    );
    return result;
  }

  Future<int> deleteAllGoals() async {
    Database? db = await this.database;
    final int result = await db!.delete(goalsTable);
    return result;
  }

  Future<List<Map<String, dynamic>>> getGoalsMap() async {
    Database? db = await this.database;
    final List<Map<String, dynamic>> result = await db!.query(goalsTable);
    return result;
  }

  Future<List<Goal>> getGoalsList() async {
    final List<Map<String, dynamic>> mapLists = await getGoalsMap();
    final List<Goal> goalsList = [];
    mapLists.forEach((goal) {
      goalsList.add(Goal.fromMap(goal));
    });
    goalsList.sort((goalA, goalB) => goalA.endDate!.compareTo(goalB.endDate!));
    return goalsList;
  }
}
