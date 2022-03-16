class Day {
  int? id;
  int? day;
  String? value;

  Day({
    this.day,
    this.value,
  });

  Day.withID({
    this.id,
    this.day,
    this.value,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['day'] = day;
    map['value'] = value;

    return map;
  }

  factory Day.fromMap(Map<String, dynamic> map) {
    return Day.withID(
      id: map['id'],
      day: map['day'],
      value: map['value'],
    );
  }
}
