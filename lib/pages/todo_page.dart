import 'package:flutter/material.dart';
import 'package:note_app/helpers/snackbar.dart';
import 'package:note_app/models/todo_model.dart';
import 'package:note_app/pages/todo_inherited_wiget.dart';
import 'package:note_app/services/todo_services.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/text_style.dart';
import 'package:note_app/widgets/completed_tab.dart';
import 'package:note_app/widgets/to_do_tab.dart';

class ToDoPage extends StatefulWidget {
  const ToDoPage({super.key});

  @override
  State<ToDoPage> createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<ToDo> allTodos = [];
  late List<ToDo> inCompletedTods = [];
  late List<ToDo> completedTodos = [];
  TodoService todoService = TodoService();
  TextEditingController _taskContoller = TextEditingController();

  @override
  void dispose() {
    _tabController.dispose();
    _taskContoller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkIfUserIsNew();
  }

  void _checkIfUserIsNew() async {
    final bool isNewUser = await todoService.isNewUser();
    if (isNewUser) {
      await todoService.createInitailTodos();
    }
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final List<ToDo> loadedTodos = await todoService.loadTodos();
    setState(
      () {
        allTodos = loadedTodos;

        //incompledt todos
        inCompletedTods = allTodos.where((todo) => !todo.isDone).toList();

        //completed Todos
        completedTodos = allTodos.where((todo) => todo.isDone).toList();
      },
    );
  }

  //method to add task

  void _addTask() async {
    try {
      if (_taskContoller.text.isNotEmpty) {
        final ToDo newTodo = ToDo(
          title: _taskContoller.text,
          date: DateTime.now(),
          time: DateTime.now(),
          isDone: false,
        );

        await todoService.addTodo(newTodo);
        setState(() {
          allTodos.add(newTodo);
          inCompletedTods.add(newTodo);
        });
        AppHelpers.showSnackbar(context, "Task Added");
        Navigator.of(context).pop();
      }
    } catch (e) {
      print(e.toString());
      AppHelpers.showSnackbar(context, "failed to Added");
    }
  }

  void openMessageModel(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.kCardColor,
          contentPadding: EdgeInsets.zero,
          title: Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Add Task",
              style: AppTextStyles.appDescription.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          content: Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _taskContoller,
              style: TextStyle(
                color: AppColors.kWhiteColor,
              ),
              decoration: InputDecoration(
                hintText: "Enter Your Task",
                hintStyle: AppTextStyles.appDescriptionSmall,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addTask();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  AppColors.kFabColor,
                ),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100))),
              ),
              child: Text(
                "Add Task",
                style: AppTextStyles.appButton,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                  AppColors.kBgColor,
                ),
              ),
              child: Text(
                "Cancel",
                style: AppTextStyles.appButton,
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TodoData(
      todos: allTodos,
      onTodosChnged: _loadTodos,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            controller: _tabController,
            tabs: [
              Tab(
                child: Text(
                  "To do",
                  style: AppTextStyles.appDescription,
                ),
              ),
              Tab(
                child: Text(
                  "Completed",
                  style: AppTextStyles.appDescription,
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            openMessageModel(context);
          },
          child: Icon(
            Icons.add,
            color: AppColors.kWhiteColor,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(50),
            ),
            side: BorderSide(
              color: AppColors.kWhiteColor,
              width: 2,
            ),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            ToDoTab(
              completedTodos: completedTodos,
              inCompletedTodos: inCompletedTods,
            ),
            CompletedTab(
              incompletedTodos: inCompletedTods,
              completedTodos: completedTodos,
            ),
          ],
        ),
      ),
    );
  }
}
