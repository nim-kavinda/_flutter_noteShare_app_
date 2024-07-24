import 'package:flutter/material.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/constant.dart';
import 'package:note_app/utils/text_style.dart';

class NoteCard extends StatelessWidget {
  final String noteCategory;
  final int noOfNotes;

  const NoteCard({
    super.key,
    required this.noteCategory,
    required this.noOfNotes,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppConstant.kDefaultPadding),
      decoration: BoxDecoration(
          color: AppColors.kCardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 5),
            )
          ]),
      child: Column(
        children: [
          Text(
            noteCategory,
            style: AppTextStyles.appSubtitle.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "$noOfNotes notes",
            style: AppTextStyles.appBody.copyWith(
              color: AppColors.kWhiteColor.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
