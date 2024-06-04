import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/bloc/todo/bloc/todo_bloc.dart';
import 'package:flutter_todo_bloc/components/my_button.dart';
import 'package:flutter_todo_bloc/components/my_textfield.dart';
import 'package:flutter_todo_bloc/data/todo.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.todo});

  final Todo todo;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.todo.todoTitle,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              MyTextField(
                controller: _controller,
                borderWidth: 2.0,
                borderColor: Colors.blue,
                borderRadius: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyButton(
                    text: 'Edit',
                    color: Colors.lightBlue,
                    onPressed: () {
                      BlocProvider.of<TodoBloc>(context)
                        ..add(
                          UpdateTodoEvent(
                            todoId: widget.todo.todoId,
                            todoTitle: _controller.text.trim(),
                          ),
                        );
                      _controller.text = '';
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 24.0,
                  ),
                  MyButton(
                    text: 'Batal',
                    color: Colors.lightBlue,
                    onPressed: () {
                      _controller.text = '';
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
