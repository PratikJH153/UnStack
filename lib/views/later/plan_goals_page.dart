import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/goal.dart';
import 'package:dailytodo/views/later/add_planned_goals_page.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/floatingactionButton.dart';
import 'package:dailytodo/widgets/goal_tile.dart';
import 'package:dailytodo/widgets/no_todo_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlanGoalsPage extends StatelessWidget {
  static const id = "/goalsPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(
        backgroundColor: kaccentColor,
        context: context,
        icon: CupertinoIcons.bolt_horizontal_fill,
        location: AddPlannedGoalsPage.id,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: FutureBuilder(
          future: DatabaseService.instance.getGoalsList(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data.length > 0
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 18.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Your Goals: ",
                                style: kDesTextStyle.copyWith(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "${snapshot.data.length}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                            bottom: 100,
                          ),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            final Goal goal = snapshot.data[index];
                            final startDate = goal.startDate!;
                            final endDate = goal.endDate!;
                            return goalTile(
                              context: context,
                              goal: goal,
                              startDate: startDate,
                              endDate: endDate,
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : NoTodoWidget(
                    height: getHeight(context),
                    image: "assets/images/goals.png",
                    title:
                        "No Goals added yet!\nAdd it to make a track of your Goals.",
                  );
          },
        ),
      ),
    );
  }
}
