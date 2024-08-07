import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/stores/todo_store.dart';
import 'package:todo_app/styles/styles.dart';
import 'package:todo_app/views/todo_view.dart';

void main() async {
  runApp(ChangeNotifierProvider(
      create: (context) => TodoStore(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: TodoView(),
        ),
      ),
    );
  }
}
