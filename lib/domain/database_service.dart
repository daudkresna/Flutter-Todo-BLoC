import 'package:flutter_todo_bloc/data/todo.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  late Future<Isar> _db;

  DatabaseService() {
    _db = openDatabase();
  }

  Future<Isar> openDatabase() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      final isar = await Isar.open([TodoSchema], directory: dir.path);
      return isar;
    }
    return Future.value(Isar.getInstance());
  }

  Future<List<Todo>> loadAllTodos() async {
    final Isar dbInstance = await _db;
    final todos = await dbInstance.todos.where().sortByTodoTitle().findAll();
    return todos;
  }

  Future<void> createNewTodo({required String todoTitle}) async {
    final Isar dbInstance = await _db;
    const uuid = Uuid();
    final todo = Todo(todoId: uuid.v4(), todoTitle: todoTitle);
    await dbInstance.writeTxn(() async {
      await dbInstance.todos.put(todo);
    });
  }

  Future<void> deleteTodo({required String todoId}) async {
    final Isar dbInstance = await _db;
    final Todo? todo =
        await dbInstance.todos.filter().todoIdEqualTo(todoId).findFirst();
    if (todo != null) {
      await dbInstance.writeTxn(() async {
        await dbInstance.todos.delete(todo.isarId);
      });
    }
  }

  Future<void> completeTodo({required String todoId}) async {
    final Isar dbInstance = await _db;
    final Todo? todo =
        await dbInstance.todos.filter().todoIdEqualTo(todoId).findFirst();
    if (todo != null) {
      await dbInstance.writeTxn(() async {
        todo.isCompleted = !todo.isCompleted;
        await dbInstance.todos.put(todo);
      });
    }
  }
}
