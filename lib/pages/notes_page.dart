import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/services/note_services.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/constant.dart';
import 'package:note_app/utils/router.dart';
import 'package:note_app/utils/text_style.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteServices noteServices = NoteServices();
  List<Note> allNotes = [];
  Map<String, List<Note>> noteWithCategory = {};

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
  }

  //check whether the user is new
  void _checkIfUserIsNew() async {
    final bool isNewUser = await noteServices.isNewUser();
    //print(isNewUser);
    //if the user is new crate the initial note
    if (isNewUser) {
      await noteServices.cretetdIntialNote();
    }
    //load the notes
    _loadNotes();
  }

  //load the notes
  Future<void> _loadNotes() async {
    final List<Note> lodedNotes = await noteServices.loadNotes();
    final Map<String, List<Note>> notesbyCategory =
        noteServices.getNotesByCategoryApp(lodedNotes);
    setState(() {
      allNotes = lodedNotes;
      noteWithCategory = notesbyCategory;
      print(noteWithCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            //go to home page
            AppRouter.router.go("/");
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: AppColors.kWhiteColor,
            width: 2,
          ),
        ),
        child: Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
          size: 30,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstant.kDefaultPadding),
        child: Column(
          children: [
            Text(
              "Notes",
              style: AppTextStyles.appTitle,
            ),
          ],
        ),
      ),
    );
  }
}
