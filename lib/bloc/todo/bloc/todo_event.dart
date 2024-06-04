part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class LoadTodosEvent extends TodoEvent {
  @override
  List<Object?> get props => [];
}

class CreateTodoEvent extends TodoEvent {
  final String todoTitle;

  CreateTodoEvent({required this.todoTitle});

  @override
  List<Object?> get props => [todoTitle];
}

class DeleteTodoEvent extends TodoEvent {
  final String todoId;

  const DeleteTodoEvent({required this.todoId});

  @override
  List<Object?> get props => [todoId];
}

class CompleteTodoEvent extends TodoEvent {
  final String todoId;

  const CompleteTodoEvent({required this.todoId});

  @override
  List<Object?> get props => [todoId];
}

class UpdateTodoEvent extends TodoEvent {
  final String todoId;
  final String todoTitle;

  UpdateTodoEvent({required this.todoId, required this.todoTitle});

  @override
  List<Object?> get props => [todoId];
}
