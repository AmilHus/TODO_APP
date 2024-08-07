import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/stores/todo_store.dart';
import 'package:todo_app/styles/styles.dart';
import 'package:todo_app/utils/adaptive_utils.dart';

class TodosListWidget extends StatelessWidget with StyleMixin {
  const TodosListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoStore>(builder: (context, todos, child) {
      return Expanded(
        child:   ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            itemBuilder: (BuildContext context, index) {
              final TodoModel todo = todos.filteredTodosList[index];
              return _buildTodo(context, todo);
            },
            itemCount: todos.filteredTodosList.length),
      );
    });
  }

  Widget _buildTodo(BuildContext context,TodoModel todo) {
    return Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.borderColor,
              width: 1.0,
            ),
          ),
        ),
        child: ListTile(
            trailing: Wrap(children: [
              Checkbox(
                value: todo.isDone,
                onChanged: (_) {
                  context.read<TodoStore>().updateTodoIsDone(todo);
                },
              ),
              IconButton(
                onPressed: () {
                  context.read<TodoStore>().removeTodo(todo,todo.id);
                },
                icon: const Icon(Icons.delete),
                color: AppColors.deleteButtonBackgroundColor,
              )
            ]),
            leading: Text(
              todo.content,
              style: AppTextStyles.body.copyWith(
                  decorationColor: AppColors.textDecorationColor,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            )));
  }
}
