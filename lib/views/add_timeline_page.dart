import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/timeline.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:dailytodo/widgets/alert_dialog.dart';
import 'package:dailytodo/widgets/app_bar.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/priority_widget.dart';
import 'package:dailytodo/widgets/snackbar_widget.dart';
import 'package:dailytodo/widgets/textFields.dart';
import 'package:flutter/material.dart';

class AddTimeLinePage extends StatefulWidget {
  static const id = '/addtimeline';

  final Timeline? timeline;

  AddTimeLinePage({this.timeline});

  @override
  _AddTimeLinePageState createState() => _AddTimeLinePageState();
}

class _AddTimeLinePageState extends State<AddTimeLinePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  int? day;

  void gettingRecentDay() async {
    int? days = await TimeLinePref.getday();
    setState(() {
      day = days;
    });
  }

  _submit() async {
    if (_titleController.text.trim().isNotEmpty &&
        _titleController.text.trim().length > 1) {
      if (widget.timeline == null) {
        Timeline timeline = Timeline(
          title: _titleController.text.trim(),
          des: _desController.text.trim(),
          dateTime: DateTime.now(),
          day: day,
        );
        await DatabaseService.instance.insertTimeLine(timeline);
        TimeLinePref.setday(day! + 1);
      } else {
        widget.timeline!.title = _titleController.text.trim();
        widget.timeline!.des = _desController.text.trim();

        await DatabaseService.instance.updateTimeline(widget.timeline!);
      }

      Navigator.of(context)
          .pushNamedAndRemoveUntil(Wrapper.id, (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        snackBarWidget(
          title: "Please enter a valid title",
          color: Colors.red[400],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.timeline != null) {
      _desController.text = widget.timeline!.des!;
      _titleController.text = widget.timeline!.title!;
      day = widget.timeline!.day;
    } else {
      gettingRecentDay();
    }
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
                  title: "Add your Day",
                  func: _submit,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dayWidget(
                      title: "Day $day",
                    ),
                    TextButton(
                      onPressed: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return alertDialog(
                              title: "Timelines",
                              label: "reset",
                              context: context,
                              isYes: () async {
                                await DatabaseService.instance.deleteAllDays();
                                TimeLinePref.setday(0);
                                return Navigator.of(context)
                                    .pushNamedAndRemoveUntil(Wrapper.id,
                                        (Route<dynamic> route) => false);
                              },
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
                SizedBox(
                  height: 25,
                ),
                Container(
                  decoration: containerDecoration,
                  child: TextFieldWidget(
                    hintText: "Title",
                    textEditingController: _titleController,
                  ),
                ),
                Container(
                  height: 80,
                  decoration: containerDecoration,
                  margin: const EdgeInsets.only(top: 20),
                  child: TextFieldWidget(
                    hintText: "Description",
                    isDes: true,
                    textEditingController: _desController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
