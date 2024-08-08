import 'package:flutter/material.dart';
import 'package:note_app/models/todo_model.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/text_style.dart';

class ToDoCard extends StatefulWidget {
  final ToDo toDo;
  final bool isCompleted;
  final Function() onCheckeBoxChanged;

  const ToDoCard({
    super.key,
    required this.toDo,
    required this.isCompleted,
    required this.onCheckeBoxChanged,
  });

  @override
  State<ToDoCard> createState() => _ToDoCardState();
}

class _ToDoCardState extends State<ToDoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: AppColors.kCardColor, borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          widget.toDo.title,
          style: AppTextStyles.appDescription,
        ),
        subtitle: Row(
          children: [
            Text(
              '${widget.toDo.date.day}/${widget.toDo.date.month}/${widget.toDo.date.year}',
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.6),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '${widget.toDo.time.hour}:${widget.toDo.time.minute}',
              style: AppTextStyles.appDescriptionSmall.copyWith(
                color: AppColors.kWhiteColor.withOpacity(0.6),
              ),
            )
          ],
        ),
        trailing: Checkbox(
          value: widget.isCompleted,
          onChanged: (value) => widget.onCheckeBoxChanged(),
        ),
      ),
    );
  }
}
