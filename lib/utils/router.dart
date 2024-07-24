import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:note_app/pages/notes_by_category.dart';
import 'package:note_app/pages/notes_page.dart';
import 'package:note_app/pages/todo_page.dart';

class AppRouter {
  static final router = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: false,
    initialLocation: "/",
    routes: [
      //Home Page
      GoRoute(
        name: "home",
        path: "/",
        builder: (context, state) {
          return HomePage();
        },
      ),

      //notes page
      GoRoute(
        name: "notes",
        path: "/notes",
        builder: (context, state) {
          return const NotesPage();
        },
      ),

      //todo page
      GoRoute(
        name: "todos",
        path: "/todos",
        builder: (context, state) {
          return const ToDoPage();
        },
      ),

      //notes by category page
      GoRoute(
        name: "category",
        path: "/category",
        builder: (context, state) {
          final String category = state.extra as String;
          return NoteByCategory(
            category: category,
          );
        },
      )
    ],
  );
}
