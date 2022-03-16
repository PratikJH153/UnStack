import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/models/timeline.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:dailytodo/widgets/alert_dialog.dart';
import 'package:dailytodo/widgets/app_bar.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/floatingactionButton.dart';
import 'package:dailytodo/widgets/priority_widget.dart';
import 'package:dailytodo/widgets/snackbar_widget.dart';
import 'package:dailytodo/widgets/textFields.dart';
import 'package:flutter/cupertino.dart';
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
        _titleController.text.trim().length > 3) {
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
      floatingActionButton: floatingActionButton(
        context: context,
        location: AddTimeLinePage.id,
        icon: CupertinoIcons.calendar_badge_plus,
        backgroundColor: kprimaryColor,
      ),
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
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dayWidget(
                      title: "Day $day",
                    ),
                    GestureDetector(
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return alertDialog(
                              title: "Timelines",
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
                          style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
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
