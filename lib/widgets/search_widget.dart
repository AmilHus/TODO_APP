import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/stores/todo_store.dart';
import 'package:todo_app/styles/styles.dart';
import '../utils/adaptive_utils.dart';

class SearchWidget extends StatelessWidget with StyleMixin {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return Row(
      children: [
        SizedBox(
          width: 10 * heightSF(context),
        ),
        Expanded(
            child: TextField(
          style: AppTextStyles.body,
          controller: controller,
          onChanged: (_) {
            context.read<TodoStore>().searchTask(controller.text);
          },
          decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 20 * widthSF(context)),
              labelText: 'Search',
              labelStyle: AppTextStyles.body,
              prefixIconColor: AppColors.searchIconColor,
              fillColor: AppColors.textColor,
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30 * radiusSF(context)),
              )),
        )),
        SizedBox(
          width: 10 * heightSF(context),
        ),
      ],
    );
  }
}
