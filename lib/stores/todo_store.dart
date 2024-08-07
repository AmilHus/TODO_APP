import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_models.dart';

class TodoStore extends ChangeNotifier {
  List<Task> get tasksList => Task.tasks;
  List<Task> get filteredTasksList => Task.tasks;

  void addTask(String taskContent) {
    if (taskContent.isNotEmpty) {
      tasksList.add(Task(content: taskContent, isDone: false));
      notifyListeners();
    }
  }

  void removeTask(Task task) {
    tasksList.remove(task);
    notifyListeners();
  }

  void toggleTask(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }

  void searchTask(String prompt) {
    if (prompt.isNotEmpty) {
      filteredTasksList.clear();
      filteredTasksList.addAll(tasksList.where((task) {
        return task.content.toLowerCase().contains(prompt.toLowerCase());
      }).toList());
      notifyListeners();
    } else {
      filteredTasksList.addAll(tasksList);
    }
  }
}
