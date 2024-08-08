import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/snackbar.dart';
import 'package:note_app/models/todo_model.dart';
import 'package:note_app/pages/todo_inherited_wiget.dart';
import 'package:note_app/services/todo_services.dart';
import 'package:note_app/utils/router.dart';
import 'package:note_app/widgets/to_do_card.dart';

class CompletedTab extends StatefulWidget {
  final List<ToDo> completedTodos;
  final List<ToDo> incompletedTodos;
  const CompletedTab({
    super.key,
    required this.completedTodos,
    required this.incompletedTodos,
  });

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

class _CompletedTabState extends State<CompletedTab> {
  //mark a todo as done
  void _markTodoAsUnDone(ToDo todo) async {
    try {
      final ToDo updatedTodo = ToDo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: false,
      );
      await TodoService().markAsDone(updatedTodo);
      setState(() {
        widget.completedTodos.remove(todo);
        widget.incompletedTodos.add(todo);
      });

      //snacbar
      AppHelpers.showSnackbar(context, "Mark As Undone");

      AppRouter.router.push(("todos"));
    } catch (e) {
      print(e.toString());
      AppHelpers.showSnackbar(context, " Falid To Mark As Undone");
    }
  }

  @override
  Widget build(BuildContext context) {
    return TodoData(
      onTodosChnged: () {},
      todos: widget.completedTodos,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.completedTodos.length,
                itemBuilder: (context, index) {
                  final ToDo todo = widget.completedTodos[index];
                  return Dismissible(
                    key: Key(todo.id.toString()),
                    onDismissed: (direction) {
                      setState(
                        () {
                          widget.completedTodos.removeAt(index);
                          TodoService().deleteTodo(todo);
                        },
                      );
                      AppHelpers.showSnackbar(context, "Deleted");
                    },
                    child: ToDoCard(
                      onCheckeBoxChanged: () => _markTodoAsUnDone(todo),
                      toDo: todo,
                      isCompleted: false,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
