import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/pages/create_new_note.dart';
import 'package:note_app/pages/home_page.dart';
import 'package:note_app/pages/notes_by_category.dart';
import 'package:note_app/pages/notes_page.dart';
import 'package:note_app/pages/single_note.dart';
import 'package:note_app/pages/todo_page.dart';
import 'package:note_app/pages/update_note_page.dart';

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
      ),

      //crate new note
      GoRoute(
        name: "create-new",
        path: "/create-note",
        builder: (context, state) {
          final isNewCategoryPage = state.extra as bool;
          return CreateNotePage(isNewCategory: isNewCategoryPage);
        },
      ),

      //edit page
      GoRoute(
        name: "edit note",
        path: "/edit-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return UpdateNotePage(
            note: note,
          );
        },
      ),
      GoRoute(
        name: "single note",
        path: "/single-note",
        builder: (context, state) {
          final Note note = state.extra as Note;
          return SingleNotePage(note: note);
        },
      )
    ],
  );
}
