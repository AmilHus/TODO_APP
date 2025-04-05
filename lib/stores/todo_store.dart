import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

import '../repository/todo_repository.dart';

class TodoStore extends ChangeNotifier {
  TodoRepository todoRepository = TodoRepository();

  List<TodoModel> filteredTodosList = [];
  List<TodoModel> allTodosList = [];

  String _currentEditingText = '';
  String _searchPromptText = '';

  bool get isSearching => _searchPromptText.isNotEmpty;
  bool get isEditable => _currentEditingText.isNotEmpty;

  void updateEditingText(String newText) {
    _currentEditingText = newText;
    notifyListeners();
  }

  void clearEditingText() {
    _currentEditingText = '';
  }

  TodoStore() {
    fetchTodos();
  }

  bool isTodoListEmpty() {
    return filteredTodosList.isEmpty;
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
    filteredTodosList.where((element) => element.id == todo.id).first.isDone =
        todo.isDone;
    allTodosList.where((element) => element.id == todo.id).first.isDone =
        todo.isDone;
    await todoRepository.updateTodoIsCompleted(todo.id, todo.isDone);
    notifyListeners();
  }

  void editTodo(TodoModel todo) async {
    filteredTodosList.where((element) => element.id == todo.id).first.content =
        _currentEditingText;
    allTodosList.where((element) => element.id == todo.id).first.content =
        _currentEditingText;
    await todoRepository.editTodo(todo.id, _currentEditingText);
    notifyListeners();
  }

  void addTodo(String todoContent, int id) {
    if (todoContent.isNotEmpty) {
      final todo = TodoModel(id: id, content: todoContent);
      todoRepository.addTodo(todo);
      filteredTodosList.add(todo);
      allTodosList.add(todo);
      notifyListeners();
    }
  }

  void removeTodo(TodoModel todo, int id) {
    todoRepository.removeTodoById(id);
    filteredTodosList.removeWhere((element) => element.id == todo.id);
    allTodosList.removeWhere((element) => element.id == todo.id);
    notifyListeners();
  }

  void searchTodo(String prompt) {
    if (prompt.isNotEmpty) {
      _searchPromptText = prompt;
      filteredTodosList.clear();
      filteredTodosList.addAll(allTodosList.where((task) {
        return task.content.toLowerCase().contains(prompt.toLowerCase());
      }).toList());
      notifyListeners();
    } else {
      _searchPromptText = '';
      fetchTodos();
      notifyListeners();
    }
  }
}
