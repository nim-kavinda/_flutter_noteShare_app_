import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/helpers/snackbar.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/services/note_services.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/router.dart';
import 'package:note_app/utils/text_style.dart';
import 'package:uuid/uuid.dart';

class CreateNotePage extends StatefulWidget {
  final bool isNewCategory;
  const CreateNotePage({
    super.key,
    required this.isNewCategory,
  });

  @override
  State<CreateNotePage> createState() => _CreateNotePageState();
}

class _CreateNotePageState extends State<CreateNotePage> {
  List<String> categories = [];
  final NoteServices noteServices = NoteServices();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _noteTitileController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  String category = '';

  @override
  void dispose() {
    _noteTitileController.dispose();
    _noteContentController.dispose();
    _categoryController.dispose();
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
    _loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create Note",
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
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextFormField(
                              controller: _categoryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Pls Enter Category";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(
                                color: AppColors.kWhiteColor,
                                fontSize: 20,
                                fontFamily: GoogleFonts.dmSans().fontFamily,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                  hintText: "New Category",
                                  hintStyle: TextStyle(
                                      color: AppColors.kWhiteColor.withOpacity(
                                        0.5,
                                      ),
                                      fontWeight: FontWeight.w500),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: AppColors.kWhiteColor,
                                      width: 2,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: AppColors.kWhiteColor
                                          .withOpacity(0.1),
                                      width: 2,
                                    ),
                                  )),
                            ),
                          )
                        : Container(
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
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.1),
                                    width: 2,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color:
                                        AppColors.kWhiteColor.withOpacity(0.1),
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
                            //save the note
                            if (_formKey.currentState!.validate()) {
                              try {
                                noteServices.addNote(
                                  Note(
                                    title: _noteTitileController.text,
                                    category: widget.isNewCategory
                                        ? _categoryController.text
                                        : category,
                                    content: _noteContentController.text,
                                    date: DateTime.now(),
                                    id: const Uuid().v4(),
                                  ),
                                );

                                //snackbar
                                AppHelpers.showSnackbar(
                                    context, "Note Saved Succesfully");

                                _noteContentController.clear();
                                _noteTitileController.clear();

                                AppRouter.router.push("/notes");
                              } catch (e) {
                                print(e);
                                AppHelpers.showSnackbar(
                                    context, "Failed to Save Note");
                              }
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Save Note",
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
