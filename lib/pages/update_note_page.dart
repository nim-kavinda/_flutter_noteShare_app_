import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/helpers/snackbar.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/services/note_services.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/router.dart';
import 'package:note_app/utils/text_style.dart';

class UpdateNotePage extends StatefulWidget {
  final Note note;
  const UpdateNotePage({
    super.key,
    required this.note,
  });

  @override
  State<UpdateNotePage> createState() => _UpdateNotePageState();
}

class _UpdateNotePageState extends State<UpdateNotePage> {
  List<String> categories = [];
  final NoteServices noteServices = NoteServices();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _noteTitileController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();

  String category = '';

  @override
  void dispose() {
    _noteTitileController.dispose();
    _noteContentController.dispose();

    super.dispose();
  }

  Future _loadCategories() async {
    categories = await noteServices.getAllCategories();
    setState(() {
      //print(categories.length);
    });
  }

  @override
  void initState() {
    _noteTitileController.text = widget.note.title;
    _noteContentController.text = widget.note.content;
    category = widget.note.category;
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Note",
          style: AppTextStyles.appSubtitle,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    //drop down

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Pls Select a category";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(
                          color: AppColors.kWhiteColor,
                          fontFamily: GoogleFonts.dmSans().fontFamily,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        isExpanded: false,
                        hint: const Text("Category"),
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.1),
                              width: 2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(
                              color: AppColors.kWhiteColor.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                        ),
                        items: categories.map(
                          (String category) {
                            return DropdownMenuItem<String>(
                                alignment: Alignment.centerLeft,
                                value: category,
                                child: Text(
                                  category,
                                  style: AppTextStyles.appButton,
                                ));
                          },
                        ).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            category = value!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //title field
                    TextFormField(
                      controller: _noteTitileController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Pls Enter a Title";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 2,
                      style: TextStyle(
                        color: AppColors.kWhiteColor.withOpacity(0.5),
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Title",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 22,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    //content
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Pls Enter your content";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 12,
                      style: TextStyle(
                        color: AppColors.kWhiteColor.withOpacity(0.5),
                      ),
                      decoration: InputDecoration(
                        hintText: "Note Content",
                        hintStyle: TextStyle(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                          fontSize: 22,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: AppColors.kWhiteColor.withOpacity(
                        0.2,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  AppColors.kFabColor)),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteServices.updateNote(
                                  Note(
                                    title: _noteTitileController.text,
                                    category: category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: widget.note.id,
                                  ),
                                );

                                //snack bar

                                AppHelpers.showSnackbar(
                                    context, "Note Update Succesfully!");
                                _noteTitileController.clear();
                                _noteContentController.clear();

                                //navigate notes page

                                AppRouter.router.push("/notes");
                              } catch (e) {
                                print(e.toString());
                                AppHelpers.showSnackbar(
                                    context, "failed to Update Succesfully!");
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Update Note",
                              style: AppTextStyles.appButton,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
