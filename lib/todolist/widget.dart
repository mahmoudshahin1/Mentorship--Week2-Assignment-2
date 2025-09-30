import 'package:flutter/material.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final bool isChecked;
  final VoidCallback onDelete;
  final VoidCallback onToggleCheck;
  final Widget dragHandle;
  final Color color;

  const TaskItem({
    super.key,
    required this.title,
    required this.isChecked,
    required this.onDelete,
    required this.onToggleCheck,
    required this.dragHandle, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(title),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete, color: Colors.white),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            dragHandle, // 👈 هيجي من ReorderableDragStartListener
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            IconButton(
              onPressed: onToggleCheck,
              icon: Icon(
                isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                color: isChecked ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
