import 'package:flutter/material.dart';
import 'package:widget_2/puzzle/presentation/page.dart' show PuzzlePage;
import 'package:widget_2/test_widget_draganddrop.dart';
import 'package:widget_2/todolist/home.dart' show TodoListPage, TodoList;
import 'package:widget_2/todolist/widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'clean puzzle',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: TodoList(),
    );
  }
}
