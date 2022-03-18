import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/challenge.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:dailytodo/widgets/alert_dialog.dart';
import 'package:dailytodo/widgets/app_bar.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/priority_widget.dart';
import 'package:dailytodo/widgets/snackbar_widget.dart';
import 'package:dailytodo/widgets/textFields.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddChallengePage extends StatefulWidget {
  static const id = '/addChallengePage';
  final Challenge? challenge;

  AddChallengePage({this.challenge});

  @override
  _AddChallengePageState createState() => _AddChallengePageState();
}

class _AddChallengePageState extends State<AddChallengePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _desController = TextEditingController();
  int? totalDays;

  _submit() async {
    if (_titleController.text.trim().isNotEmpty &&
        _titleController.text.trim().length > 3 &&
        totalDays != null) {
      if (widget.challenge == null) {
        Challenge challenge = Challenge(
          title: _titleController.text.trim(),
          des: _desController.text.trim(),
          completedDays: 0,
          isDone: 0,
          totalDays: totalDays,
          doneDate: DateTime.now().subtract(
            Duration(days: 1),
          ),
        );
        await DatabaseService.instance.insertChallenge(challenge);
      } else {
        widget.challenge!.title = _titleController.text.trim();
        widget.challenge!.des = _desController.text.trim();

        await DatabaseService.instance.updateChallenge(widget.challenge!);
      }
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Wrapper.id, (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(
          title: totalDays != null
              ? "Please enter a valid title"
              : "Please select the days",
          color: Colors.red[400],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.challenge != null) {
      _titleController.text = widget.challenge!.title!;
      _desController.text = widget.challenge!.des!;
      totalDays = widget.challenge!.totalDays;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _desController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar(
                  context: context,
                  title: "Add a Challenge",
                  func: _submit,
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 2),
                      child: priorityWidget(
                        title: "Challenge",
                        color: kaccentColor,
                        onTap: () {},
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        showCupertinoDialog(
                          context: context,
                          builder: (context) {
                            return alertDialog(
                              context: context,
                              isYes: () {
                                DatabaseService.instance.deleteAllChallenges();
                                Navigator.of(context).pushNamedAndRemoveUntil(
                                    Wrapper.id,
                                    (Route<dynamic> route) => false);
                              },
                              title: "Challenges",
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "Reset",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: containerDecoration,
                  child: TextFieldWidget(
                    hintText: "Enter your Challenge",
                    textEditingController: _titleController,
                  ),
                ),
                Container(
                  height: 100,
                  margin: const EdgeInsets.only(top: 20),
                  decoration: containerDecoration,
                  child: TextFieldWidget(
                    hintText: "Enter the Description",
                    isDes: true,
                    textEditingController: _desController,
                  ),
                ),
                widget.challenge == null
                    ? Container(
                        margin: const EdgeInsets.only(top: 20),
                        decoration: containerDecoration,
                        child: TextField(
                          readOnly: true,
                          onTap: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) {
                                return Container(
                                  child: CupertinoPicker(
                                    itemExtent: 50,
                                    useMagnifier: true,
                                    onSelectedItemChanged: (val) {
                                      setState(() {
                                        totalDays = val + 1;
                                      });
                                    },
                                    children: List.generate(
                                      100,
                                      (index) => Center(
                                        child: Text(
                                          "${index + 1}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 12),
                            border: InputBorder.none,
                            hintText: totalDays != null
                                ? "$totalDays Days"
                                : "Select Number of Days",
                            hintStyle: totalDays != null
                                ? kTextFieldHintTextStyle.copyWith(
                                    fontSize: 18,
                                    color: Colors.white,
                                  )
                                : kHintTextFieldTextStyle,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
