import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/text_style.dart';

class SingleNotePage extends StatefulWidget {
  final Note note;
  const SingleNotePage({
    super.key,
    required this.note,
  });

  @override
  State<SingleNotePage> createState() => _SingleNotePageState();
}

class _SingleNotePageState extends State<SingleNotePage> {
  @override
  Widget build(BuildContext context) {
    //formated date
    final formatedDate = DateFormat.yMMMd().format(widget.note.date);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Note"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                widget.note.title,
                style: AppTextStyles.appTitle,
              ),
              SizedBox(
                height: 9,
              ),
              Text(
                widget.note.category,
                style: AppTextStyles.appButton.copyWith(
                  color: AppColors.kWhiteColor.withOpacity(0.6),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                formatedDate,
                style: AppTextStyles.appDescriptionSmall.copyWith(
                  color: AppColors.kFabColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.note.content,
                style: AppTextStyles.appDescription
                    .copyWith(color: AppColors.kWhiteColor.withOpacity(0.6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
