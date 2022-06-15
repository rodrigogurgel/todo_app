class Todo {
  String id;
  String description;
  bool done;

  Todo({required this.id, required this.description, this.done = false});

  factory Todo.fromJson(Map<String, dynamic> json) {
    final id = json['id'];
    final description = json['description'] ?? "";
    final done = json['done'];
    
    return Todo(id: id, description: description, done: done);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['description'] = description;
    data['done'] = done;
    return data;
  }
}
