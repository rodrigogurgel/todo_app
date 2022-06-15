import 'package:flutter/material.dart';

import '../models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onPressed;
  final ValueChanged<bool?>? onChanged;

  const TodoTile(
      {Key? key,
      required this.todo,
      required this.onPressed,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Checkbox(
          value: todo.done,
          onChanged: onChanged,
        ),
        title: Text(todo.description),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onPressed,
        ),
      ),
    );
  }

  static Widget emptyTodoTile() {
    return const Card(
      child: ListTile(
        leading: Checkbox(
          value: false,
          onChanged: null,
        ),
        title: Text(""),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: null,
        ),
      ),
    );
  }
}
