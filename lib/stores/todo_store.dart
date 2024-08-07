
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

import '../repository/todo_repository.dart';

class TodoStore extends ChangeNotifier {
  final TodoRepository _todoRepository = TodoRepository();

  List<TodoModel> filteredTodosList = [];
  List<TodoModel> allTodosList = [];

  TodoStore() {
    fetchTodos();
  }

  void fetchTodos() async {
    filteredTodosList = await _todoRepository.getAllTodos();
    allTodosList = await _todoRepository.getAllTodos();
    notifyListeners();
  }

  void updateTodoIsDone(TodoModel todo) async {
    todo.isDone = !todo.isDone;
    await _todoRepository.updateTodoIsCompleted(todo.id, todo.isDone);
    notifyListeners();
  }

  void addTodo(String todoContent, int id) {
    if (todoContent.isNotEmpty) {
      final todo = TodoModel(id: id,content: todoContent);
      filteredTodosList.add(todo);
      _todoRepository.addTodo(todo);
      notifyListeners();
    }
  }

  void removeTodo(TodoModel todo,int id ) {
    filteredTodosList.remove(todo);
    _todoRepository.removeTodoById(id);
    notifyListeners();

  }

  void searchTodo(String prompt) {
    if (prompt.isNotEmpty) {
      filteredTodosList.clear();
      filteredTodosList.addAll(allTodosList.where((task) {
        return task.content.toLowerCase().contains(prompt.toLowerCase());
      }).toList());
      notifyListeners();
    } else {
      filteredTodosList.clear();
      filteredTodosList.addAll(allTodosList);
      notifyListeners();
    }
  }
}
