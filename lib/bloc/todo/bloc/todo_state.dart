part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

final class TodoInitial extends TodoState {
  @override
  List<Object> get props => [];
}

final class TodoLoading extends TodoState {
  @override
  List<Object> get props => [];
}

final class TodoLoaded extends TodoState {
  final List<Todo> todos;

  const TodoLoaded({required this.todos});

  @override
  List<Object?> get props => [todos];
}

final class TodoError extends TodoState {
  final String error;

  TodoError({required this.error});

  @override
  List<Object?> get props => [error];
}
