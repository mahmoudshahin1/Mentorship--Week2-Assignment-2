import 'package:flutter/material.dart';
import 'package:widget_2/todolist/widget.dart' show TaskItem;

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  State<TodoList> createState() => _OneListDismissibleState();
}

class _OneListDismissibleState extends State<TodoList> {
  List<Map<String, dynamic>> tasks = [
    {"title": "Learn new widgets like drag and drop.", "isChecked": false , "Color" : Colors.red},
    {"title": "Khali Chat, I brought you a detailed explanation of the topic and know how to use it", "isChecked": false,"Color" : Colors.blue},
    {"title": "Apply the code and know how to use each widget", "isChecked": false,"Color" : Colors.greenAccent},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Tasks")),
      body: ReorderableListView.builder(
        itemCount: tasks.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = tasks.removeAt(oldIndex);
            tasks.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskItem(

            key: ValueKey(task["title"]),
            color: task["Color"],
            title: task["title"],
            isChecked: task["isChecked"],
            onDelete: () {
              setState(() {
                tasks.removeAt(index);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${task["title"]} deleted")),
              );
            },
            onToggleCheck: () {
              setState(() {
                task["isChecked"] = !task["isChecked"];
              });
            },
            dragHandle: ReorderableDragStartListener(
              index: index,
              child: Icon(Icons.menu, color: Colors.white),
            ),
          );
        },
      ),
    );
  }
}
