import '../models/todo_model.dart';
import '../db/todo_db.dart';

class TodoRepository {
  final TodoDBService _todoDB = TodoDBService();

  Future<int> addTodo(TodoModel todo) {
    return _todoDB.insertTodo(todo);
  }

  Future<int> removeTodoById(int id) {
    return _todoDB.deleteTodo(id);
  }

  Future<List<TodoModel>> getAllTodos() {
    return _todoDB.getTodos();
  }

   Future<int> updateTodoIsCompleted(int id, bool isDone) {
    return _todoDB.updateTodoIsDone(id, isDone);
  }
}
