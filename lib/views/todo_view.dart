import 'package:flutter/material.dart';
import 'package:todo_app/utils/adaptive_utils.dart';
import 'package:todo_app/widgets/widgets.dart';

class TodoView extends StatelessWidget with StyleMixin {
  const TodoView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40 * heightSF(context)),
        const SearchWidget(),
        SizedBox(
          height: 10 * heightSF(context),
        ),
        const TodosListWidget(),
        SizedBox(
          height: 10 * heightSF(context),
        ),
        const AddTodoWidget(),
        SizedBox(
          height: 20 * heightSF(context),
        ),
      ],
    );
  }
}
