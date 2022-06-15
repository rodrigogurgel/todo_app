
import '../models/todo.dart';

class TodoState {
  Map<String, Todo> todos;

  TodoState({required this.todos});
}

class TodoInitialState extends TodoState {
  TodoInitialState() : super(todos: {});
}

class LoadingTodoState extends TodoState {
  LoadingTodoState({required Map<String, Todo> todos}) : super(todos: todos);
}

class TodoSuccessState extends TodoState {
  final String? message;

  TodoSuccessState({required Map<String, Todo> todos, this.message})
      : super(todos: todos);
}

class TodoErrorState extends TodoState {
  final String message;
  TodoErrorState({required Map<String, Todo> todos, required this.message})
      : super(todos: todos);
}
