import 'package:flutter/material.dart';
import 'package:note_app/models/todo_model.dart';

class TodoData extends InheritedWidget {
  final List<ToDo> todos;
  final Function() onTodosChnged;

  const TodoData({
    super.key,
    required super.child,
    required this.todos,
    required this.onTodosChnged,
  });

  static TodoData? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TodoData>();
  }

  @override
  bool updateShouldNotify(covariant TodoData oldWidget) {
    return todos != oldWidget.todos;
  }
}
