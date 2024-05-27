import 'package:isar/isar.dart';

part 'todo.g.dart';

@collection
class Todo {
  Id isarId = Isar.autoIncrement;
  String todoId;
  String todoTitle;
  bool isCompleted = false;

  Todo({required this.todoId, required this.todoTitle});
}
