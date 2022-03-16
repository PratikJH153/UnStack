import 'package:shared_preferences/shared_preferences.dart';

class Timeline {
  int? id;
  String? title;
  String? des;
  DateTime? dateTime;
  int? day;

  Timeline({
    this.title,
    this.des,
    this.day,
    this.dateTime,
  });

  Timeline.withID({
    this.id,
    this.title,
    this.des,
    this.day,
    this.dateTime,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['des'] = des;
    map['day'] = day;
    map['dateTime'] = dateTime!.toIso8601String();

    return map;
  }

  factory Timeline.fromMap(Map<String, dynamic> map) {
    return Timeline.withID(
      id: map['id'],
      title: map['title'],
      des: map['des'],
      dateTime: DateTime.parse(map['dateTime']),
      day: map['day'],
    );
  }
}

class TimeLinePref {
  static void setday(int day) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('day', day);
  }

  static Future<int?> getday() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('day');
  }
}
