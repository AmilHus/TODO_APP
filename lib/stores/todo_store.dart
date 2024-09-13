
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

import '../repository/todo_repository.dart';

class TodoStore extends ChangeNotifier {
  TodoRepository todoRepository = TodoRepository();

  List<TodoModel> filteredTodosList = [];
  List<TodoModel> allTodosList = [];

  TodoStore() {
    fetchTodos();
  }

  void fetchTodos() async {
    filteredTodosList.clear();
    allTodosList.clear();
    filteredTodosList = await todoRepository.getAllTodos();
    allTodosList = await todoRepository.getAllTodos();
    notifyListeners();
  }

  void updateTodoIsDone(TodoModel todo) async {
    todo.isDone = !todo.isDone;
    await todoRepository.updateTodoIsCompleted(todo.id, todo.isDone);
    fetchTodos();
    notifyListeners();
  }

  void addTodo(String todoContent, int id) {
    if (todoContent.isNotEmpty) {
      final todo = TodoModel(id: id,content: todoContent);
      todoRepository.addTodo(todo);
      fetchTodos();
      notifyListeners();
    }
  }

  void removeTodo(TodoModel todo,int id ) {
    todoRepository.removeTodoById(id);
    fetchTodos();
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
      fetchTodos();
      notifyListeners();
    }
  }
}
