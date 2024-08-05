import 'package:flutter/material.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/text_style.dart';

class NoteCategoryCard extends StatefulWidget {
  final String noteTitle;
  final String noteContent;
  final Future Function() removeNote;
  final Future Function() editNote;
  final void Function() viewSingleNote;
  const NoteCategoryCard({
    super.key,
    required this.noteTitle,
    required this.noteContent,
    required this.removeNote,
    required this.editNote,
    required this.viewSingleNote,
  });

  @override
  State<NoteCategoryCard> createState() => _NoteCategoryCardState();
}

class _NoteCategoryCardState extends State<NoteCategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.kCardColor,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: widget.editNote,
                  icon: Icon(
                    Icons.edit_outlined,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                  onPressed: widget.removeNote,
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                    size: 25,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: widget.viewSingleNote,
              child: Column(
                children: [
                  Text(
                    widget.noteTitle,
                    style: AppTextStyles.appSubtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    widget.noteContent,
                    style: AppTextStyles.appDescriptionSmall.copyWith(
                      color: AppColors.kWhiteColor.withOpacity(0.5),
                    ),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
