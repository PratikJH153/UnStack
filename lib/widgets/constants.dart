import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

const Color kprimaryColor = Color(0xFF212024);
const Color kaccentColor = const Color.fromARGB(255, 121, 89, 250);
const Color kcanvasColor = Color(0xFFff3d6b);

const kIntroTextStyle = TextStyle(
  fontSize: 25,
  fontWeight: FontWeight.w700,
  fontFamily: "Ubuntu",
  letterSpacing: 1.3,
  wordSpacing: 1.5,
);

const kDesTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w600,
  color: Color(0xFFBDBDBD),
  fontFamily: "QuickSand",
  height: 1.4,
  letterSpacing: 1.3,
  wordSpacing: 1.5,
);

const kTextFieldHintTextStyle = TextStyle(
  fontFamily: "QuickSand",
  fontSize: 22,
  fontWeight: FontWeight.w700,
);

const kHintTextFieldTextStyle = TextStyle(
  color: Color(0xFF757575),
  fontSize: 15,
  fontWeight: FontWeight.bold,
  fontFamily: 'QuickSand',
  wordSpacing: 1.3,
);

const Map priorities = {
  'Easy': Color(0xFF66BB6A),
  'Medium': Color(0xFFFFA726),
  'Hard': Color(0xFFEF5350),
};

final formattedString = DateFormat('MMM dd yyyy');
final goalDateString = DateFormat('dd MMMM yyyy');

final containerDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [Colors.white.withOpacity(0.1), Colors.white.withOpacity(0.02)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  border: Border.all(
    color: Colors.white.withOpacity(0.05),
  ),
  borderRadius: BorderRadius.circular(10),
);
