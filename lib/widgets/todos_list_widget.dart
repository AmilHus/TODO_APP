import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/stores/todo_store.dart';
import 'package:todo_app/styles/styles.dart';
import 'package:todo_app/utils/adaptive_utils.dart';

class TodosListWidget extends StatelessWidget with StyleMixin {
  const TodosListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoStore>(builder: (context, tasks, child) {
      return Expanded(
        child: ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            itemBuilder: (BuildContext context, index) {
              final task = tasks.filteredTasksList[index];
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
                          value: task.isDone,
                          onChanged: (_) {
                            context.read<TodoStore>().toggleTask(task);
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<TodoStore>().removeTask(task);
                          },
                          icon: const Icon(Icons.delete),
                          color: AppColors.deleteButtonBackgroundColor,
                        )
                      ]),
                      leading: Text(
                        task.content,
                        style: AppTextStyles.body.copyWith(
                            decorationColor: AppColors.textDecorationColor,
                            decoration: task.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      )));
            },
            itemCount: tasks.filteredTasksList.length),
      );
    });
  }
}
