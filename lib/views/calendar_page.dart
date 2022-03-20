import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/day.dart';
import 'package:dailytodo/widgets/alert_dialog.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/no_todo_widget.dart';
import 'package:dailytodo/widgets/tap_day_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 10),
                child: Text(
                  "Your Daily Tracker",
                  style: kTextFieldHintTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return alertDialog(
                        context: context,
                        isYes: () async {
                          await DatabaseService.instance.deleteDays();
                          setState(() {});
                          Navigator.pop(context);
                        },
                        label: "reset",
                        title: "Daily Tracks",
                      );
                    },
                  );
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.red[400],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: FutureBuilder(
              future: DatabaseService.instance.getDayList(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return snapshot.data.length < 1
                    ? Center(
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(20),
                          child: NoTodoWidget(
                            height: getHeight(context),
                            image: "assets/images/soon1.png",
                            title:
                                "Daily Tracker Coming soon...\nTo make you Grow more!",
                          ),
                        ),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(
                          bottom: 150,
                        ),
                        itemCount: snapshot.data.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 1.0,
                          mainAxisSpacing: 1.0,
                        ),
                        itemBuilder: (context, index) {
                          final day = Day.withID(
                            id: snapshot.data[index].id,
                            day: snapshot.data[index].day,
                            value: snapshot.data[index].value,
                          );
                          return TapDayWidget(
                            index: day.day,
                            value: day.value,
                            doneFunc: () async {
                              setState(() {
                                if (day.value == "null") {
                                  day.value = "true";
                                } else if (day.value == "true") {
                                  day.value = "false";
                                } else {
                                  day.value = "null";
                                }
                              });
                              await DatabaseService.instance.updateDay(day);
                            },
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}
