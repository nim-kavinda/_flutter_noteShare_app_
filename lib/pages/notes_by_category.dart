import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:note_app/helpers/snackbar.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/services/note_services.dart';
import 'package:note_app/utils/constant.dart';
import 'package:note_app/utils/router.dart';
import 'package:note_app/utils/text_style.dart';
import 'package:note_app/widgets/note_category_card.dart';

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

  //edit note
  void _editNote(Note note) {
    //navigate to the edit note page
    AppRouter.router.push("/edit-note", extra: note);
  }

  //remove note
  Future<void> _removeNote(String id) async {
    try {
      await noteServices.deleteNote(id);
      if (context.mounted) {
        AppHelpers.showSnackbar(context, "Note Deleted Sucessfully");
      }
    } catch (e) {
      print(e.toString());
      if (context.mounted) {
        AppHelpers.showSnackbar(context, "Note Deleted Sucessfully");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            //go to note page
            AppRouter.router.push("/notes");
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstant.kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Text(
                widget.category,
                style: AppTextStyles.appTitle,
              ),
              const SizedBox(
                height: 30,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppConstant.kDefaultPadding,
                  mainAxisSpacing: AppConstant.kDefaultPadding,
                  childAspectRatio: 7 / 11,
                ),
                itemCount: noteList.length,
                itemBuilder: (context, index) {
                  return NoteCategoryCard(
                    noteTitle: noteList[index].title,
                    noteContent: noteList[index].content,
                    removeNote: () async {
                      await _removeNote(noteList[index].id);

                      setState(() {
                        noteList.removeAt(index);
                      });
                    },
                    editNote: () async {
                      _editNote(noteList[index]);
                    },
                    viewSingleNote: () {
                      AppRouter.router
                          .push("/single-note", extra: noteList[index]);
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
