import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/models/todo_model.dart';
import 'package:note_app/pages/todo_inherited_wiget.dart';
import 'package:note_app/services/note_services.dart';
import 'package:note_app/services/todo_services.dart';
import 'package:note_app/utils/router.dart';
import 'package:note_app/utils/text_style.dart';
import 'package:note_app/widgets/main_screen_todo_card.dart';
import 'package:note_app/widgets/notes_to_to_card.dart';
import 'package:note_app/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NoteServices noteServices = NoteServices();
  TodoService todoServices = TodoService();

  List<Note> allnotes = [];
  List<ToDo> alltodos = [];

  @override
  void initState() {
    _checkUserIsNew();
    super.initState();
  }

  void _checkUserIsNew() async {
    final isNewUser =
        await noteServices.isNewUser() || await todoServices.isNewUser();

    if (isNewUser) {
      await noteServices.cretetdIntialNote();
      await todoServices.createInitailTodos();
    }
    _loadNotes();
    _loadTodos();
  }

  Future<void> _loadNotes() async {
    final List<Note> loadNotes = await noteServices.loadNotes();

    setState(() {
      allnotes = loadNotes;
    });
  }

  Future<void> _loadTodos() async {
    final List<ToDo> loadedTodos = await todoServices.loadTodos();

    setState(() {
      alltodos = loadedTodos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TodoData(
      todos: alltodos,
      onTodosChnged: () {
        setState((todos) {
          alltodos = todos;
        } as VoidCallback);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'NoteSphere',
            style: AppTextStyles.appTitle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              const SizedBox(
                height: 15,
              ),
              ProgressCard(
                completedTask: alltodos
                    .where(
                      (todo) => todo.isDone,
                    )
                    .length,
                totalTask: alltodos.length,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // go to the notes page
                      AppRouter.router.push("/notes");
                    },
                    child: NotesToDoCards(
                      title: "Notes",
                      description: "${allnotes.length.toString()} notes",
                      icon: Icons.bookmark_add_outlined,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // go to the to do list page
                      AppRouter.router.push("/todos");
                    },
                    child: NotesToDoCards(
                      title: "To Do List",
                      description: "${alltodos.length.toString()} Task",
                      icon: Icons.today_outlined,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today's Progress",
                    style: AppTextStyles.appSubtitle,
                  ),
                  Text(
                    "See All",
                    style: AppTextStyles.appButton,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              alltodos.isEmpty
                  ? Container(
                      margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "No tasks for today , Add some tasks to get started!",
                              style: AppTextStyles.appDescription.copyWith(
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.blue,
                                ),
                              ),
                              onPressed: () {
                                AppRouter.router.push("/todos");
                              },
                              child: const Text("Add Task"),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: alltodos.length,
                        itemBuilder: (BuildContext context, int index) {
                          final ToDo todo = alltodos[index];
                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: MainScreenTodoCard(
                                title: todo.title,
                                date: todo.date.toString(),
                                time: todo.time.toString(),
                                isDone: todo.isDone),
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
