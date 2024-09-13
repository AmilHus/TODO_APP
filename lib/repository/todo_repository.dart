import '../models/todo_model.dart';
import '../db/todo_db.dart';

class TodoRepository {
  TodoDBService todoDB = TodoDBService();

  Future<int> addTodo(TodoModel todo) {
    return todoDB.insertTodo(todo);
  }

  Future<int> removeTodoById(int id) {
    return todoDB.deleteTodo(id);
  }

  Future<List<TodoModel>> getAllTodos() {
    return todoDB.getTodos();
  }

   Future<int> updateTodoIsCompleted(int id, bool isDone) {
    return todoDB.updateTodoIsDone(id, isDone);
  }
}
