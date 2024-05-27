import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_bloc/data/todo.dart';
import 'package:flutter_todo_bloc/domain/database_service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final DatabaseService _databaseService;
  TodoBloc(this._databaseService) : super(TodoInitial()) {
    on<LoadTodosEvent>((event, emit) async {
      // TODO: implement event handler
      final todos = _databaseService.loadAllTodos();
      List<Todo> todoList = await todos;
      emit(TodoLoaded(todos: todoList));
    });

    on<CreateTodoEvent>((event, emit) async {
      await _databaseService.createNewTodo(todoTitle: event.todoTitle);
      add(LoadTodosEvent());
    });
    on<DeleteTodoEvent>((event, emit) async {
      await _databaseService.deleteTodo(todoId: event.todoId);
      add(LoadTodosEvent());
    });
    on<CompleteTodoEvent>((event, emit) async {
      await _databaseService.completeTodo(todoId: event.todoId);
      add(LoadTodosEvent());
    });
  }
}
