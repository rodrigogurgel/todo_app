import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';
import '../bloc/todo_state.dart';
import '../components/todo_tile.dart';
import '../models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();
  }

  void _onChange(BuildContext context, TodoState state) {
    if (state is TodoSuccessState) {
      _loading = false;
    }

    if (state is TodoErrorState) {
      _loading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            state.message,
          ),
        ),
      );
    }

    if (state is LoadingTodoState) {
      _loading = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TodoBloc>(context);
    final controller = TextEditingController();
    const uuid = Uuid();

    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) => _onChange(context, state),
      child: BlocBuilder<TodoBloc, TodoState>(
        bloc: bloc,
        builder: (context, state) {
          final todos = state.todos.values.toList();
          return Scaffold(
            appBar: AppBar(
              title: const Text("Todo"),
              bottom: _loading
                  ? const PreferredSize(
                      preferredSize: Size.fromHeight(1),
                      child: LinearProgressIndicator(),
                    )
                  : null,
              actions: [
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Criar um novo todo'),
                        content: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Descrição do todo',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              controller.text = "";
                              Navigator.pop(context);
                            },
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () {
                              bloc.add(AddTodoEvent(
                                todo: Todo(
                                    id: uuid.v4(),
                                    description: controller.text),
                              ));
                              controller.text = "";
                              Navigator.pop(context);
                            },
                            child: const Text('Criar'),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                bloc.add(LoadTodoEvent());
              },
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => TodoTile(
                  onChanged: (bool? value) {
                    bloc.add(UpdateTodoEvent(
                        todo: Todo(
                      id: todos[index].id,
                      description: todos[index].description,
                      done: value!,
                    )));
                  },
                  todo: todos[index],
                  onPressed: () {
                    bloc.add(RemoveTodoEvent(todo: todos[index]));
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
