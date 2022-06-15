import 'package:dio/dio.dart';

import '../models/todo.dart';

class TodoRepository {
  Future<List<Todo>> getAll() async {
    Response<List> response = await Dio().get("https://todo-reactive-app.herokuapp.com/todos");
    return response.data?.map((e) => Todo.fromJson(e)).toList() ?? [];
  }

  Future deleteTodo(String id) async {
    await Dio().delete("https://todo-reactive-app.herokuapp.com/todos/$id");
  }

  Future<Todo> createTodo(Todo todo) async {
    var response = await Dio().post("https://todo-reactive-app.herokuapp.com/todos", data: todo);
    return Todo.fromJson(response.data);
  }

  Future updateTodo(Todo todo) async {
    await Dio().patch("https://todo-reactive-app.herokuapp.com/todos/${todo.id}", data: todo);
  }
}
