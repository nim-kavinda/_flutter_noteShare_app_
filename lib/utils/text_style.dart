import 'package:flutter/material.dart';
import 'package:note_app/utils/colors.dart';

class AppTextStyles {
  static TextStyle appTitle = TextStyle(
    fontSize: 28,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );

  static TextStyle appSubtitle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.kWhiteColor,
  );

  static TextStyle appDescription = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.kWhiteColor,
  );

  static TextStyle appDescriptionSmall = TextStyle(
    fontSize: 14,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.w400,
  );

  static TextStyle appBody = TextStyle(
    color: AppColors.kWhiteColor,
    fontSize: 16,
  );

  static TextStyle appButton = TextStyle(
    fontSize: 16,
    color: AppColors.kWhiteColor,
    fontWeight: FontWeight.bold,
  );
}
