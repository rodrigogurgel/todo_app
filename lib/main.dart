import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/repositories/todo_repository.dart';
import 'package:todo_app/screens/home_screen.dart';

import 'bloc/todo_bloc.dart';
import 'bloc/todo_event.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => TodoRepository(),
          ),
        ],
        child: BlocProvider<TodoBloc>(
          create: (BuildContext context) => TodoBloc(
            repository: RepositoryProvider.of<TodoRepository>(context),
          )..add(LoadTodoEvent()),
          child: const HomeScreen(),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
