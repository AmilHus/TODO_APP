import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/stores/todo_store.dart';
import 'package:todo_app/styles/styles.dart';
import 'package:todo_app/utils/adaptive_utils.dart';

class TodosListWidget extends StatefulWidget {
  const TodosListWidget({super.key});

  @override
  State<TodosListWidget> createState() => _TodosListWidgetState();
}

class _TodosListWidgetState extends State<TodosListWidget> with StyleMixin {
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoStore>(builder: (context, todos, child) {
      return Expanded(
        child:  todos.isTodoListEmpty() ? Lottie.asset('assets/lottie/empty_screen_lottie.json', repeat: false) : ListView.builder(
          padding: const EdgeInsets.only(top: 0),
          itemBuilder: (BuildContext context, index) {
            final TodoModel todo = todos.filteredTodosList[index];
            return _buildTodo(context, todo);
          },
          itemCount: todos.filteredTodosList.length,
        ),
      );
    });
  }

  Widget _buildTodo(BuildContext context, TodoModel todo) {
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
        onLongPress: () {
          context.read<TodoStore>().updateEditingText(todo.content);
          _editingController.text = todo.content;
          showDialog(
            context: context,
            builder: (context) {
              return _buildEditDialog(todo);
            },
          );
        },
        trailing: Wrap(children: [
          Checkbox(
            value: todo.isDone,
            onChanged: (_) {
              context.read<TodoStore>().updateTodoIsDone(todo);
            },
          ),
          IconButton(
            onPressed: () {
              context.read<TodoStore>().removeTodo(todo, todo.id);
            },
            icon: const Icon(Icons.delete),
            color: AppColors.deleteButtonBackgroundColor,
          )
        ]),
        leading: SizedBox(
          width: 250 * widthSF(context),
          height: 23 * heightSF(context),
          child: Text(
            todo.content,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body.copyWith(
                decorationColor: AppColors.textDecorationColor,
                decoration: todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none),
          ),
        ),
      ),
    );
  }

  AlertDialog _buildEditDialog(TodoModel todo){
    return AlertDialog(
                backgroundColor: AppColors.backgroundColor,
                title: Text(
                  'Edit Todo',
                  style: AppTextStyles.body.copyWith(
                    decorationColor: AppColors.textColor,
                  ),
                ),
                content: TextField(
                  autofocus: true,
                  style:
                      AppTextStyles.body.copyWith(color: AppColors.textColor),
                  controller: _editingController,
                  onChanged: (value) {
                    context.read<TodoStore>().updateEditingText(value);
                    todo.content = value;
                  },
                  decoration: const InputDecoration(hintText: "Enter new todo"),
                ),
                actions: [
                  Consumer<TodoStore>(
                    builder: (context, store, _) => TextButton(
                      onPressed: store.isEditable ? () {
                        context.read<TodoStore>().editTodo(todo);
                        Navigator.of(context).pop();
                      } : null,
                      child: const Text('Save'),
                    ),
                  ),
                ],
              );
  }
}
