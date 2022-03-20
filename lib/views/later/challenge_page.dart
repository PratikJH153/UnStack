import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/challenge.dart';
import 'package:dailytodo/views/later/add_challenge_page.dart';
import 'package:dailytodo/widgets/confirmation_slider.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/no_todo_widget.dart';
import 'package:dailytodo/widgets/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  void confirmHabit(Challenge challenge) async {
    if (challenge.doneDate!.difference(DateTime.now()) >= Duration(days: 2)) {
      challenge.completedDays = 0;
      challenge.doneDate = DateTime.now().subtract(Duration(days: 1));
      await DatabaseService.instance.updateChallenge(challenge);
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(
          color: Colors.red[400],
          title: "Sorry you've missed your habit for more than 2 days",
        ),
      );
    }

    if (challenge.doneDate!.day != DateTime.now().day) {
      challenge.completedDays = challenge.completedDays! + 1;
      challenge.doneDate = DateTime.now();

      if (challenge.completedDays == challenge.totalDays) {
        challenge.isDone = 1;
      }
      await DatabaseService.instance.updateChallenge(challenge);

      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(
          color: Colors.green[400],
          title: "Well Done! Keep on Going and keep yourself on Track",
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(
          color: Colors.red[400],
          title: "You've already marked your Today's Habit",
        ),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () => Navigator.pushNamed(context, AddChallengePage.id),
          backgroundColor: kaccentColor,
          child: Icon(
            CupertinoIcons.add,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: FutureBuilder(
          future: DatabaseService.instance.getChallengeList(),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return snapshot.data.length > 0
                ? Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 100,
                          ),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return Container();
                            }

                            final Challenge challenge =
                                snapshot.data[index - 1];

                            return GestureDetector(
                              onDoubleTap: () async {
                                await DatabaseService.instance
                                    .deleteChallenge(challenge.id);

                                setState(() {});
                              },
                              child: Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 10,
                                ),
                                decoration: containerDecoration,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: getWidth(context) * 0.60,
                                          child: Text(
                                            challenge.title!,
                                            style: kTextFieldHintTextStyle
                                                .copyWith(
                                              fontSize: 20,
                                              color: challenge.isDone == 1
                                                  ? Colors.grey[700]
                                                  : Colors.white,
                                              decoration: challenge.isDone == 1
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                              CupertinoIcons.pencil_outline),
                                          onPressed: () =>
                                              Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AddChallengePage(
                                                challenge: challenge,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        challenge.des!,
                                        style: kHintTextFieldTextStyle.copyWith(
                                          fontSize: 14,
                                          color: challenge.isDone == 1
                                              ? Colors.grey[800]
                                              : Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: RichText(
                                        text: TextSpan(
                                            style: kHintTextFieldTextStyle
                                                .copyWith(
                                              fontSize: 13,
                                              color: challenge.isDone == 1
                                                  ? Colors.grey[800]
                                                  : Colors.grey[700],
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    "${challenge.completedDays}/${challenge.totalDays}",
                                                style: kTextFieldHintTextStyle
                                                    .copyWith(
                                                  fontSize: 13,
                                                  color: challenge.isDone == 1
                                                      ? Colors.grey[800]
                                                      : kcanvasColor,
                                                  letterSpacing: 2,
                                                ),
                                              ),
                                              TextSpan(
                                                text: " Days left",
                                              ),
                                            ]),
                                      ),
                                    ),
                                    Container(
                                      child: LinearPercentIndicator(
                                        backgroundColor: kprimaryColor,
                                        linearGradient: LinearGradient(
                                          colors: const [
                                            Color(0xFF4797ff),
                                            Color(0xFF643dff),
                                            Color(0xFFff7092),
                                            Color(0xFFf5426c),
                                          ],
                                        ),
                                        percent: challenge.completedDays! /
                                            challenge.totalDays!,
                                        lineHeight: 2,
                                        animation: true,
                                        animateFromLastPercent: true,
                                        animationDuration: 1500,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 15,
                                        ),
                                      ),
                                    ),
                                    challenge.isDone == 0
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                              top: 30.0,
                                              bottom: 10,
                                            ),
                                            child: confirmationSlider(
                                              height: 50,
                                              onConfirmed: () =>
                                                  confirmHabit(challenge),
                                            ),
                                          )
                                        : Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 25),
                                          ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: 1 + snapshot.data.length as int?,
                        ),
                      ),
                    ],
                  )
                : NoTodoWidget(
                    height: getHeight(context),
                    image: "assets/images/soon1.png",
                    title:
                        "No Challenges added yet!\nAdd it to make a get to the right track.",
                  );
          },
        ),
      ),
    );
  }
}
