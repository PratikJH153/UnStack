// class Challenge {
//   int? id;
//   String? title;
//   int? totalDays;
//   String? des;
//   int? isDone;
//   int? completedDays;

//   DateTime? doneDate;

//   Challenge({
//     this.title,
//     this.des,
//     this.totalDays,
//     this.isDone,
//     this.completedDays,
//     this.doneDate,
//   });

//   Challenge.withID({
//     this.id,
//     this.title,
//     this.des,
//     this.isDone,
//     this.totalDays,
//     this.completedDays,
//     this.doneDate,
//   });

//   Map<String, dynamic> toMap() {
//     var map = Map<String, dynamic>();
//     if (id != null) {
//       map['id'] = id;
//     }
//     map['title'] = title;
//     map['des'] = des;
//     map['isDone'] = isDone;
//     map['totalDays'] = totalDays;
//     map['completedDays'] = completedDays;

//     map['doneDate'] = doneDate!.toIso8601String();

//     return map;
//   }

//   factory Challenge.fromMap(Map<String, dynamic> map) {
//     return Challenge.withID(
//       id: map['id'],
//       title: map['title'],
//       des: map['des'],
//       isDone: map['isDone'],
//       totalDays: map['totalDays'],
//       completedDays: map['completedDays'],
//       doneDate: DateTime.parse(map['doneDate']),
//     );
//   }
// }
