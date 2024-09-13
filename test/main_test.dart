

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/repository/todo_repository.dart';
import 'package:todo_app/db/todo_db.dart';

class MockTodoDBService extends TodoDBService {
  final List<TodoModel> _todos = [];

  @override
  Future<int> insertTodo(TodoModel todo) async {
    _todos.add(todo);
    return Future.value(todo.id); // Simulates the insertion with returning the id
  }

  @override
  Future<int> deleteTodo(int id) async {
    _todos.removeWhere((todo) => todo.id == id);
    return Future.value(id); // Simulates deletion with returning the id
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    return Future.value(List.unmodifiable(_todos)); // Returns an immutable list of todos
  }

  @override
  Future<int> updateTodoIsDone(int id, bool isDone) async {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index].isDone = isDone;
      return Future.value(id); // Simulates update with returning the id
    }
    return Future.value(-1); // Indicates failure to update
  }
}

void main() {
  group('TodoRepository', () {
    late TodoRepository todoRepository;
    late MockTodoDBService mockDBService;

    setUp(() {
      mockDBService = MockTodoDBService();
      todoRepository = TodoRepository();
      todoRepository.todoDB = mockDBService;
    });

    test('should add a todo', () async {
      // Arrange
      final todo = TodoModel(id: 1, content: 'Test Todo');

      // Act
      final resultId = await todoRepository.addTodo(todo);

      // Assert
      expect(resultId, todo.id);
      expect(await mockDBService.getTodos(), contains(todo));
    });

    test('should remove a todo', () async {
      // Arrange
      final todo = TodoModel(id: 1, content: 'Test Todo');
      await todoRepository.addTodo(todo);

      // Act
      await todoRepository.removeTodoById(todo.id);

      // Assert
      expect(await mockDBService.getTodos(), isNot(contains(todo)));
    });

    test('should get all todos', () async {
      // Arrange
      final todo1 = TodoModel(id: 1, content: 'Test Todo 1');
      final todo2 = TodoModel(id: 2, content: 'Test Todo 2');
      await todoRepository.addTodo(todo1);
      await todoRepository.addTodo(todo2);

      // Act
      final todos = await todoRepository.getAllTodos();

      // Assert
      expect(todos, containsAll([todo1, todo2]));
    });

    test('should update a todo', () async {
      // Arrange
      final todo = TodoModel(id: 1, content: 'Test Todo', isDone: false);
      await todoRepository.addTodo(todo);

      // Act
      await todoRepository.updateTodoIsCompleted(todo.id, true);

      // Assert
      final updatedTodo = (await mockDBService.getTodos()).firstWhere((t) => t.id == todo.id);
      expect(updatedTodo.isDone, true);
    });
  });
}
