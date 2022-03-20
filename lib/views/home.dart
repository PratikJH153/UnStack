import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/helper/ad_helper.dart';
import 'package:dailytodo/helper/display_name.dart';
import 'package:dailytodo/models/todo.dart';
import 'package:dailytodo/helper/todo_data.dart';
import 'package:dailytodo/views/add_todo_page.dart';
import 'package:dailytodo/widgets/dummy_tile.dart';
import 'package:dailytodo/widgets/first_todo_widget.dart';
import 'package:dailytodo/widgets/floatingactionButton.dart';
import 'package:dailytodo/widgets/no_todo_widget.dart';
import 'package:dailytodo/widgets/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../widgets/constants.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  static const id = '/home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ConfettiController _controllerCenter;
  late String displayName;
  final AdmobHelper admobHelper = AdmobHelper();
  // bool isEmpty = false;

  void getData() async {
    String? names = await DisplayName.getName();
    await Provider.of<TodoData>(context, listen: false).getTodoFromDatabase();

    setState(() {
      displayName = names!;
    });
  }

  void refreshList() async {
    Provider.of<TodoData>(context, listen: false).getTodoData();
  }

  @override
  void initState() {
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 3));
    getData();
    if (Provider.of<TodoData>(context, listen: false).todoCount == 1) {
      admobHelper.showInterad(() {});
    }
    super.initState();
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  /// A custom Path to paint stars.
  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / numberOfPoints);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius * cos(step),
          halfWidth + externalRadius * sin(step));
      path.lineTo(halfWidth + internalRadius * cos(step + halfDegreesPerStep),
          halfWidth + internalRadius * sin(step + halfDegreesPerStep));
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    double height = getHeight(context);
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AddTodoPage.id),
          backgroundColor: kaccentColor,
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Container(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 20),
                  child: ConfettiWidget(
                    confettiController: _controllerCenter,
                    blastDirectionality: BlastDirectionality
                        .explosive, // don't specify a direction, blast randomly
                    shouldLoop:
                        false, // start again as soon as the animation is finished
                    colors: const [
                      Colors.green,
                      Colors.blue,
                      Colors.pink,
                      Colors.orange,
                      Colors.purple
                    ], // manually specify the colors to be used
                    createParticlePath: drawStar, // define a custom shape/path.
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !Provider.of<TodoData>(context).isListEmpty
                        ? Consumer<TodoData>(
                            builder: (context, todoData, child) {
                              return Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 40),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(4.0, 4.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 3.0,
                                          ),
                                          BoxShadow(
                                            color: Colors.black12,
                                            offset: Offset(-4.0, -4.0),
                                            blurRadius: 10.0,
                                            spreadRadius: 3.0,
                                          ),
                                        ],
                                      ),
                                      child: CircularPercentIndicator(
                                        arcType: ArcType.FULL,
                                        animateFromLastPercent: true,
                                        arcBackgroundColor: Colors.black26,
                                        radius: 130.0,
                                        animation: true,
                                        animationDuration: 1200,
                                        lineWidth: 20.0,
                                        percent: todoData.percentage,
                                        center: Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              RichText(
                                                textAlign: TextAlign.center,
                                                text: TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text:
                                                          "${(todoData.percentage * 100).round()}%\n",
                                                      style: kIntroTextStyle
                                                          .copyWith(
                                                        fontSize: 35,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: "Completed",
                                                      style: kDesTextStyle
                                                          .copyWith(
                                                              fontSize: 16,
                                                              height: 1.6),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
                                        backgroundColor: kprimaryColor,
                                        linearGradient:
                                            LinearGradient(colors: const [
                                          Color(0xFF4797ff),
                                          Color(0xFF643dff),
                                          Color(0xFFff7092),
                                          Color(0xFFf5426c),
                                        ]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 26, vertical: 25),
                                    child: !Provider.of<TodoData>(context)
                                            .isCompleted
                                        ? FirstTodoWidget(
                                            todo: todoData.getTodo(0),
                                            onConfirmed: () async {
                                              final todos = todoData.getTodo(0);
                                              _controllerCenter.play();
                                              Todo todo = Todo(
                                                status: 1,
                                                priority: todos.priority,
                                                title: todos.title,
                                              );
                                              todo.id = todos.id;
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                snackBarWidget(
                                                  title:
                                                      "Congratulations on completing your task!",
                                                  color: Colors.green[400],
                                                ),
                                              );
                                              setState(() {
                                                Provider.of<TodoData>(context,
                                                        listen: false)
                                                    .updateTodo(todo);

                                                refreshList();
                                              });
                                              await DatabaseService.instance
                                                  .updateTodo(todo);
                                              if (todoData.completedTasks ==
                                                  1) {
                                                admobHelper.showInterad(() {});
                                              } else if (todoData.todoCount ==
                                                  todoData.completedTasks) {
                                                admobHelper.showInterad(() {});
                                              }
                                            },
                                          )
                                        : DummyTile(),
                                  ),
                                ],
                              );
                            },
                          )
                        : Container(
                            margin: EdgeInsets.only(top: height * 0.05),
                            child: NoTodoWidget(
                              height: height,
                              title:
                                  "Pump yourself up!\nAdd Tasks to Grow More!",
                              image: "assets/images/notodo.png",
                            ),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
