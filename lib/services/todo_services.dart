import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:note_app/models/todo_model.dart';

class TodoService {
  // all todos
  List<ToDo> todos = [
    ToDo(
      title: "Read a Book",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    ToDo(
      title: "Go for a Walk",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
    ToDo(
      title: "Complete Assignment",
      date: DateTime.now(),
      time: DateTime.now(),
      isDone: false,
    ),
  ];

  //create the database reference for todos
  final _myBox = Hive.box("todos");

  //check weather the user is new user
  Future<bool> isNewUser() async {
    return _myBox.isEmpty;
  }

  // Method to create the initial todos if the box is empty
  Future<void> createInitailTodos() async {
    if (_myBox.isEmpty) {
      await _myBox.put("todos", todos);
    }
  }

  // Method to load the todos
  Future<List<ToDo>> loadTodos() async {
    final dynamic todos = await _myBox.get("todos");
    if (todos != null && todos is List<dynamic>) {
      return todos.cast<ToDo>().toList();
    }
    return [];
  }

  //mark the to do as done

  Future<void> markAsDone(ToDo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      final int index = allTodos.indexWhere((element) => element.id == todo.id);
      allTodos[index] = todo;

      await _myBox.put("todos", allTodos);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> addTodo(ToDo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      allTodos.add(todo);

      await _myBox.put("Todos", allTodos);
    } catch (e) {
      print(e.toString());
    }
  }

  //delete a todo
  Future<void> deleteTodo(ToDo todo) async {
    try {
      final dynamic allTodos = await _myBox.get("todos");
      allTodos.remove(todo);

      await _myBox.put("todos", allTodos);
    } catch (e) {
      print(e.toString());
    }
  }
}
