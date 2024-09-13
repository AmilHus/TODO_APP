class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late TodoStore todoStore;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    todoStore = TodoStore();
    todoStore._todoRepository = mockTodoRepository;
  });

  group('TodoStore Tests', () {
    test('Should fetch todos and update lists', () async {
      // Arrange
      final todos = [
        TodoModel(id: 1, content: 'Test Todo 1'),
        TodoModel(id: 2, content: 'Test Todo 2'),
      ];

      when(mockTodoRepository.getAllTodos()).thenAnswer((_) async => todos);

      // Act
      await todoStore.fetchTodos();

      // Assert
      expect(todoStore.filteredTodosList, todos);
      expect(todoStore.allTodosList, todos);
    });

    test('Should update todo isDone status', () async {
      // Arrange
      final todo = TodoModel(id: 1, content: 'Test Todo', isDone: false);

      when(mockTodoRepository.updateTodoIsCompleted(todo.id, true)).thenAnswer((_) async {});

      // Act
      await todoStore.updateTodoIsDone(todo);

      // Assert
      expect(todo.isDone, true);
      verify(mockTodoRepository.updateTodoIsCompleted(todo.id, true)).called(1);
    });

    test('Should add a new todo', () async {
      // Arrange
      final todo = TodoModel(id: 1, content: 'New Todo');
      
      when(mockTodoRepository.addTodo(todo)).thenAnswer((_) async {});

      // Act
      todoStore.addTodo('New Todo', 1);

      // Assert
      expect(todoStore.filteredTodosList.contains(todo), true);
      verify(mockTodoRepository.addTodo(todo)).called(1);
    });

    test('Should remove a todo', () async {
      // Arrange
      final todo = TodoModel(id: 1, content: 'Remove Todo');
      todoStore.filteredTodosList.add(todo);

      when(mockTodoRepository.removeTodoById(todo.id)).thenAnswer((_) async {});

      // Act
      todoStore.removeTodo(todo, todo.id);

      // Assert
      expect(todoStore.filteredTodosList.contains(todo), false);
      verify(mockTodoRepository.removeTodoById(todo.id)).called(1);
    });

    test('Should search todos', () async {
      // Arrange
      final todo1 = TodoModel(id: 1, content: 'Search Todo 1');
      final todo2 = TodoModel(id: 2, content: 'Another Todo');
      todoStore.allTodosList = [todo1, todo2];
      todoStore.filteredTodosList = [todo1, todo2];

      // Act
      todoStore.searchTodo('Search');

      // Assert
      expect(todoStore.filteredTodosList, [todo1]);
    });

    test('Should return all todos when search prompt is empty', () async {
      // Arrange
      final todo1 = TodoModel(id: 1, content: 'Search Todo 1');
      final todo2 = TodoModel(id: 2, content: 'Another Todo');
      todoStore.allTodosList = [todo1, todo2];

      // Act
      todoStore.searchTodo('');

      // Assert
      expect(todoStore.filteredTodosList, [todo1, todo2]);
    });
  });
}
