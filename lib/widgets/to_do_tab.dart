import 'package:flutter/material.dart';
import 'package:note_app/helpers/snackbar.dart';
import 'package:note_app/models/todo_model.dart';
import 'package:note_app/pages/todo_inherited_wiget.dart';
import 'package:note_app/services/todo_services.dart';
import 'package:note_app/utils/router.dart';
import 'package:note_app/utils/text_style.dart';
import 'package:note_app/widgets/to_do_card.dart';

class ToDoTab extends StatefulWidget {
  final List<ToDo> inCompletedTodos;
  final List<ToDo> completedTodos;
  const ToDoTab({
    super.key,
    required this.inCompletedTodos,
    required this.completedTodos,
  });

  @override
  State<ToDoTab> createState() => _ToDoTabState();
}

class _ToDoTabState extends State<ToDoTab> {
  //mark a todo as done
  void _markTodoAsDone(ToDo todo) async {
    try {
      final ToDo updatedTodo = ToDo(
        title: todo.title,
        date: todo.date,
        time: todo.time,
        isDone: true,
      );

      await TodoService().markAsDone(updatedTodo);

      // snackbar
      AppHelpers.showSnackbar(context, "Mark As DOne");
      setState(() {
        widget.inCompletedTodos.remove(todo);
        widget.completedTodos.add(updatedTodo);
      });
      AppRouter.router.push("/todos");
    } catch (e) {
      print(e.toString());
      AppHelpers.showSnackbar(context, " Falid To Mark As done");
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      widget.inCompletedTodos.sort(
        (a, b) => a.time.compareTo(b.time),
      );
    });
    return TodoData(
      todos: widget.inCompletedTodos,
      onTodosChnged: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.inCompletedTodos.length,
                itemBuilder: (context, index) {
                  final ToDo todo = widget.inCompletedTodos[index];
                  return Dismissible(
                    key: Key(todo.id.toString()),
                    onDismissed: (direction) {
                      setState(
                        () {
                          widget.inCompletedTodos.removeAt(index);
                          TodoService().deleteTodo(todo);
                        },
                      );
                      AppHelpers.showSnackbar(context, "Deleted");
                    },
                    child: ToDoCard(
                      onCheckeBoxChanged: () => _markTodoAsDone(todo),
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
