# Flutter Todo List with Swipe to Delete & Check Toggle

## 📌 Overview
This project is a simple **Todo List** built with Flutter.  
It demonstrates how to:
- Create a **list of tasks** with a toggle check/uncheck feature.
- Swipe items from **right to left** to delete them using `Dismissible`.
- Separate the list item widget into a reusable component.
- Prepare the project for further extensions (animations, drag & drop, etc.).

---

## 🛠 Features

1. **Check/Uncheck Tasks**
   - Implemented with `IconButton`.
   - Tapping the icon toggles between `Icons.check_box` and `Icons.check_box_outline_blank`.
  
     ## 📸 Screenshot

![Todo App Screenshot](assets/Screenshot 2025-9-30141611.png)

2. **Swipe to Delete**
   - Implemented using Flutter's `Dismissible` widget.
   - Swiping an item removes it from the list with a smooth animation.

3. **Reusable Widget**
   - Each task item is separated into a custom widget file (e.g. `task_item.dart`).
   - Makes the code cleaner and easier to maintain.

---

## 📂 Project Structure
