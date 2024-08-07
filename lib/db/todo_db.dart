import 'db_helper.dart';
import '../models/todo_model.dart';

class TodoDBService {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<int> insertTodo(TodoModel todo) async {
    final db = await _databaseHelper.database;
    return await db.insert('todos', todo.toMap());
  }

  Future<int> updateTodoIsDone(int id, bool isDone) async {
    final db = await _databaseHelper.database;
    return await db.update(
      'todos',
      {'isDone': isDone ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteTodo(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete('todos', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('todos');
    return List.generate(maps.length, (i) {
      return TodoModel.fromMap(maps[i]);
    });
  }
}