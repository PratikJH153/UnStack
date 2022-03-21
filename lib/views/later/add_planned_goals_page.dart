// import 'package:dailytodo/database/database.dart';
// import 'package:dailytodo/models/goal.dart';
// import 'package:dailytodo/views/wrapper.dart';
// import 'package:dailytodo/widgets/app_bar.dart';
// import 'package:dailytodo/widgets/constants.dart';
// import 'package:dailytodo/widgets/date_textfield.dart';
// import 'package:dailytodo/widgets/priority_widget.dart';
// import 'package:dailytodo/widgets/snackbar_widget.dart';
// import 'package:dailytodo/widgets/textFields.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class AddPlannedGoalsPage extends StatefulWidget {
//   static const id = "/addGoals";
//   final Goal? goal;

//   AddPlannedGoalsPage({this.goal});

//   @override
//   _AddPlannedGoalsPageState createState() => _AddPlannedGoalsPageState();
// }

// class _AddPlannedGoalsPageState extends State<AddPlannedGoalsPage> {
//   String? _priority = "Easy";
//   DateTime? _startDate = DateTime.now();
//   DateTime? _endDate = DateTime.now();

//   final TextEditingController _startDateController = TextEditingController();
//   final TextEditingController _endDateController = TextEditingController();

//   final TextEditingController _titleController = TextEditingController();

//   _submit() async {
//     if (_titleController.text.trim().isNotEmpty &&
//         _titleController.text.trim().length > 3) {
//       if (_startDate == null || _endDate == null) {
//         return ScaffoldMessenger.of(context).showSnackBar(
//           snackBarWidget(
//             title: "Please select a date",
//             color: Colors.red[400],
//           ),
//         );
//       }
//       if (widget.goal == null) {
//         Goal goal = Goal(
//           title: _titleController.text.trim(),
//           priority: _priority,
//           startDate: _startDate,
//           endDate: _endDate,
//         );
//         await DatabaseService.instance.insertGoal(goal);
//       } else {
//         widget.goal!.title = _titleController.text.trim();
//         widget.goal!.priority = _priority;
//         widget.goal!.startDate = _startDate;
//         widget.goal!.endDate = _endDate;

//         await DatabaseService.instance.updateGoal(widget.goal!);
//       }
//       Navigator.of(context)
//           .pushNamedAndRemoveUntil(Wrapper.id, (Route<dynamic> route) => false);
//     } else {
//       return ScaffoldMessenger.of(context).showSnackBar(
//         snackBarWidget(
//           title: "Please enter a valid title",
//           color: Colors.red[400],
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     if (widget.goal != null) {
//       _priority = widget.goal!.priority;
//       _titleController.text = widget.goal!.title!;
//       _startDate = widget.goal!.startDate;
//       _endDate = widget.goal!.endDate;
//       _startDateController.text = formattedString.format(_startDate!);
//       _endDateController.text = formattedString.format(_endDate!);
//     } else {
//       _startDate = DateTime.now();
//       _endDate = DateTime.now();
//       _startDateController.text = formattedString.format(_startDate!);
//       _endDateController.text = formattedString.format(_endDate!);
//     }
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 appBar(
//                   context: context,
//                   func: _submit,
//                   title: "Add your Goal",
//                 ),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Container(
//                   child: Row(
//                     children: [
//                       Row(
//                         children: priorities.entries
//                             .map(
//                               (entry) => priorityWidget(
//                                 color: entry.key == _priority
//                                     ? entry.value
//                                     : Colors.white.withOpacity(0.1),
//                                 title: entry.key,
//                                 onTap: () {
//                                   setState(
//                                     () {
//                                       _priority = entry.key;
//                                     },
//                                   );
//                                 },
//                               ),
//                             )
//                             .toList(),
//                       ),
//                       Spacer(),
//                       widget.goal != null
//                           ? IconButton(
//                               onPressed: () async {
//                                 await DatabaseService.instance
//                                     .deleteGoal(widget.goal!.id);
//                                 Navigator.of(context).pushNamedAndRemoveUntil(
//                                     Wrapper.id,
//                                     (Route<dynamic> route) => false);
//                               },
//                               icon: Icon(
//                                 CupertinoIcons.delete_right,
//                               ),
//                             )
//                           : Container(),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Container(
//                   decoration: containerDecoration,
//                   child: TextFieldWidget(
//                     hintText: "Enter the Goal",
//                     textEditingController: _titleController,
//                   ),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 20),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: dateTextField(
//                           context: context,
//                           controller: _startDateController,
//                           time: _startDate,
//                           title: "Start Date",
//                           onTap: (pickedDate) {
//                             setState(
//                               () {
//                                 _startDate = pickedDate;
//                                 _startDateController.text =
//                                     formattedString.format(_startDate!);
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Expanded(
//                         child: dateTextField(
//                           context: context,
//                           controller: _endDateController,
//                           time: _endDate,
//                           title: "End Date",
//                           onTap: (pickedDate) {
//                             setState(
//                               () {
//                                 _endDate = pickedDate;
//                                 _endDateController.text =
//                                     formattedString.format(_endDate!);
//                               },
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
