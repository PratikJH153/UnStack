class Todo {
  int? id;
  String? title;
  String? priority;
  int? status;

  Todo({
    this.title,
    this.priority,
    this.status,
  });

  Todo.withID({
    this.id,
    this.title,
    this.priority,
    this.status,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;

    map['priority'] = priority;
    map['status'] = status;

    return map;
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo.withID(
      id: map['id'],
      title: map['title'],
      priority: map['priority'],
      status: map['status'],
    );
  }
}
