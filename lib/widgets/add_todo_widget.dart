import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/stores/todo_store.dart';
import 'package:todo_app/utils/adaptive_utils.dart';

import '../styles/styles.dart';

class AddTodoWidget extends StatelessWidget with StyleMixin {
  const AddTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Row(
      children: [
        SizedBox(width: 10 * heightSF(context)),
        Expanded(
            child: TextField(
          controller: controller,
          style: AppTextStyles.body,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20 * widthSF(context)),
              labelText: 'Add a new task',
              labelStyle: AppTextStyles.body,
              fillColor: AppColors.textColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30 * radiusSF(context)),
              )),
        )),
        SizedBox(width: 10 * heightSF(context)),
        FloatingActionButton(
          backgroundColor: AppColors.addButtonColor,
          onPressed: () {
            context.read<TodoStore>().addTask(controller.text);
            controller.clear();
          },
          child: const Icon(
            Icons.add,
            color: AppColors.addIconColor,
          ),
        ),
        SizedBox(width: 10 * heightSF(context)),
      ],
    );
  }
}
