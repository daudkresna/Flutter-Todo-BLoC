import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/todo/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/domain/database_service.dart';
import 'package:flutter_todo_bloc/screens/edit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo App Bloc'),
      ),
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              BlocProvider.of<TodoBloc>(context).add(
                CreateTodoEvent(
                  todoTitle: 'Test',
                ),
              );
            },
            icon: const Icon(
              Icons.add,
              size: 30,
              color: Colors.green,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoaded) {
                  return ListView.builder(
                    itemCount: state.todos.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider.value(
                                value: BlocProvider.of<TodoBloc>(context),
                                child: EditPage(todo: state.todos[index]),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                width: 1,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: state.todos[index].isCompleted,
                                    onChanged: (value) {
                                      BlocProvider.of<TodoBloc>(context).add(
                                        CompleteTodoEvent(
                                            todoId: state.todos[index].todoId),
                                      );
                                    },
                                  ),
                                  Text(
                                    state.todos[index].todoTitle,
                                    style: TextStyle(
                                      decoration: state.todos[index].isCompleted
                                          ? TextDecoration.lineThrough
                                          : null,
                                    ),
                                  ),
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    BlocProvider.of<TodoBloc>(context).add(
                                      DeleteTodoEvent(
                                          todoId: state.todos[index].todoId),
                                    );
                                  },
                                  icon: const Icon(Icons.delete))
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
