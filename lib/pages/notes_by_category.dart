import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/services/note_services.dart';

class NoteByCategory extends StatefulWidget {
  final String category;
  const NoteByCategory({
    super.key,
    required this.category,
  });

  @override
  State<NoteByCategory> createState() => _NoteByCategoryState();
}

class _NoteByCategoryState extends State<NoteByCategory> {
  final NoteServices noteServices = NoteServices();
  List<Note> noteList = [];

  @override
  void initState() {
    super.initState();
    _loadNotesByCategory();
  }

  //load all notes by category
  Future<void> _loadNotesByCategory() async {
    noteList = await noteServices.getNotesByCategoryName(widget.category);
    setState(() {
      print(noteList.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
      ),
    );
  }
}
