// class Goal {
//   int? id;
//   String? title;
//   String? priority;
//   DateTime? startDate;
//   DateTime? endDate;

//   Goal({
//     this.title,
//     this.priority,
//     this.startDate,
//     this.endDate,
//   });

//   Goal.withID({
//     this.id,
//     this.title,
//     this.priority,
//     this.startDate,
//     this.endDate,
//   });

//   Map<String, dynamic> toMap() {
//     var map = Map<String, dynamic>();
//     if (id != null) {
//       map['id'] = id;
//     }
//     map['title'] = title;
//     map['priority'] = priority;
//     map['startDate'] = startDate!.toIso8601String();
//     map['endDate'] = endDate!.toIso8601String();

//     return map;
//   }

//   factory Goal.fromMap(Map<String, dynamic> map) {
//     return Goal.withID(
//       id: map['id'],
//       title: map['title'],
//       priority: map['priority'],
//       startDate: DateTime.parse(map['startDate']),
//       endDate: DateTime.parse(map['endDate']),
//     );
//   }
// }
