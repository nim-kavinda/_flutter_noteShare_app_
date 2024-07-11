import 'package:flutter/material.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/constant.dart';
import 'package:note_app/utils/text_style.dart';

class ProgressCard extends StatefulWidget {
  final int completedTask;
  final int totalTask;
  const ProgressCard({
    super.key,
    required this.completedTask,
    required this.totalTask,
  });

  @override
  State<ProgressCard> createState() => _ProgressCardState();
}

class _ProgressCardState extends State<ProgressCard> {
  @override
  Widget build(BuildContext context) {
    // calculation from the completion percerntage
    double completionPercn = widget.totalTask != 0
        ? (widget.completedTask / widget.totalTask) * 100
        : 0;
    return Container(
      padding: const EdgeInsets.all(AppConstant.kDefaultPadding),
      decoration: BoxDecoration(
        color: AppColors.kCardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Today's Progress",
                style: AppTextStyles.appSubtitle,
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.68,
                child: Text(
                  "You have Completed ${widget.completedTask} out of ${widget.totalTask} tasks,\nkeep up the progress!",
                  style: AppTextStyles.appDescriptionSmall.copyWith(
                    color: AppColors.kWhiteColor.withOpacity(0.5),
                  ),
                ),
              )
            ],
          ),
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.177,
                height: MediaQuery.of(context).size.width * 0.177,
                decoration: BoxDecoration(
                  gradient: AppColors().kPrimaryGradient,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Positioned.fill(
                  child: Center(
                child: Text(
                  "$completionPercn%",
                  style: AppTextStyles.appSubtitle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
