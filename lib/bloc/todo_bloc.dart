import 'package:bloc/bloc.dart';

import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  Map<String, Todo> _todos = {};

  TodoBloc({required this.repository}) : super(TodoInitialState()) {
    on<LoadTodoEvent>(_loadTodo);

    on<AddTodoEvent>(_addTodo);

    on<RemoveTodoEvent>(_removeTodo);

    on<UpdateTodoEvent>(_updateTodoEvent);
  }

  void _loadTodo(LoadTodoEvent event, Emitter emit) async {
    emit(LoadingTodoState(todos: _todos));
    try {
      _todos = {for (var todo in await repository.getAll()) todo.id: todo};
      emit(TodoSuccessState(todos: _todos));
    } catch (e) {
      emit(TodoErrorState(todos: _todos, message: "Erro ao buscar os TODOs"));
    }
  }

  void _addTodo(AddTodoEvent event, Emitter emit) async {
    var currentTodos = {..._todos};
    _todos[event.todo.id] = event.todo;
    emit(LoadingTodoState(todos: _todos));
    try {
      await repository.createTodo(event.todo);
      emit(TodoSuccessState(todos: _todos, message: "TODO Criado com sucesso"));
    } catch (e) {
      _todos = currentTodos;
      emit(
          TodoErrorState(todos: _todos, message: "Erro ao criar um novo TODO"));
    }
  }

  void _removeTodo(RemoveTodoEvent event, Emitter emit) async {
    var currentTodos = {..._todos};
    _todos.remove(event.todo.id);
    emit(LoadingTodoState(todos: _todos));
    try {
      await repository.deleteTodo(event.todo.id);
      emit(TodoSuccessState(
          todos: _todos, message: "TODO deletado com sucesso"));
    } catch (e) {
      _todos = currentTodos;
      emit(TodoErrorState(todos: _todos, message: "Erro ao deletar o TODO"));
    }
  }

  void _updateTodoEvent(UpdateTodoEvent event, Emitter emit) async {
    var currentTodos = {..._todos};
    _todos[event.todo.id] = event.todo;
    emit(LoadingTodoState(todos: _todos));
    try {
      await repository.updateTodo(event.todo);
      emit(TodoSuccessState(
          todos: _todos, message: "TODO atualizado com sucesso"));
    } catch (e) {
      _todos = currentTodos;
      emit(TodoErrorState(todos: _todos, message: "Erro ao atualizar o TODO"));
    }
  }

  void checkConnectivity() async {}
}
