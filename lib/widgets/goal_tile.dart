import 'package:dailytodo/models/goal.dart';
import 'package:dailytodo/views/add_planned_goals_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'constants.dart';

Widget goalTile({
  required BuildContext context,
  required Goal goal,
  required var startDate,
  required var endDate,
}) {
  return Slidable(
    closeOnScroll: true,
    startActionPane: ActionPane(
      motion: Container(),
      children: [
        IconButton(
          icon: const Icon(
            CupertinoIcons.pencil_outline,
            color: Colors.white,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPlannedGoalsPage(
                goal: goal,
              ),
            ),
          ),
        ),
      ],
    ),
    key: ValueKey(goal),
    child: Container(
      width: double.infinity,
      key: ValueKey(goal),
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: kprimaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: new LinearGradient(
          stops: const [
            0.02,
            0.02,
          ],
          colors: [priorities[goal.priority], kprimaryColor],
        ),
      ),
      margin: const EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Text(
              "${goalDateString.format(startDate)} - ${goalDateString.format(endDate)}",
              style: kDesTextStyle.copyWith(
                letterSpacing: 1,
              ),
            ),
          ),
          Text(
            goal.title!,
            style: kTextFieldHintTextStyle.copyWith(
              fontSize: 18,
              height: 1.4,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 2,
              top: 13,
            ),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        "${endDate.difference(DateTime.now().subtract(Duration(days: 1))).inDays} ",
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.1,
                      color: priorities[goal.priority],
                      fontWeight: FontWeight.bold,
                      fontFamily: '',
                    ),
                  ),
                  TextSpan(
                    text: "Remaining Days",
                    style: kDesTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
