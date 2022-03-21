import 'package:dailytodo/database/database.dart';
import 'package:dailytodo/helper/display_name.dart';
import 'package:dailytodo/models/timeline.dart';
import 'package:dailytodo/views/wrapper.dart';
import 'package:dailytodo/widgets/back_button.dart';
import 'package:dailytodo/widgets/constants.dart';
import 'package:dailytodo/widgets/next_button.dart';
import 'package:flutter/material.dart';

class AskNamePage extends StatefulWidget {
  static const id = '/asknamePage';

  @override
  State<AskNamePage> createState() => _AskNamePageState();
}

class _AskNamePageState extends State<AskNamePage> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();

  void getName(BuildContext context) async {
    final _form = _formKey.currentState!;
    if (_form.validate()) {
      setState(() {
        _isLoading = true;
      });
      _form.save();
      DisplayName.setName(_nameController.text.trim());
      TimeLinePref.setday(0);
      await DatabaseService.instance.insertDay();
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context)
          .pushNamedAndRemoveUntil(Wrapper.id, (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 30,
          right: 15,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            backButton(context),
            !_isLoading
                ? nextButton(() => getName(context))
                : CircularProgressIndicator(),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF6e9fff),
                        Color(0xFF2b5dff),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "UnStack",
                        style: kIntroTextStyle,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "A place where growth is step by step with satisfaction of the work done in a day",
                        textAlign: TextAlign.left,
                        style: kDesTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 15,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Okay firstly,\nWhat can I call you?",
                        style: kTextFieldHintTextStyle,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Form(
                            key: _formKey,
                            child: Container(
                              decoration: containerDecoration,
                              child: TextFormField(
                                controller: _nameController,
                                autofocus: false,
                                keyboardType: TextInputType.text,
                                autocorrect: true,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.only(left: 12),
                                  border: InputBorder.none,
                                  hintText: "Enter your name",
                                  hintStyle: kHintTextFieldTextStyle,
                                ),
                                validator: (val) {
                                  return val!.trim().length < 3
                                      ? "Please enter a valid name"
                                      : val.trim().length > 20
                                          ? "Please enter characters less than 20."
                                          : null;
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
