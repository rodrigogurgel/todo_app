
import '../models/todo.dart';

abstract class TodoEvent {}

class LoadTodoEvent extends TodoEvent {}

class AddTodoEvent extends TodoEvent {
  final Todo todo;

  AddTodoEvent({
    required this.todo,
  });
}

class RemoveTodoEvent extends TodoEvent {
  final Todo todo;

  RemoveTodoEvent({
    required this.todo,
  });
}

class UpdateTodoEvent extends TodoEvent {
  final Todo todo;

  UpdateTodoEvent({
    required this.todo,
  });
}
