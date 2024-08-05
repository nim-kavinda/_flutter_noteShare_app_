import 'package:flutter/material.dart';
import 'package:note_app/utils/colors.dart';
import 'package:note_app/utils/text_style.dart';

class AppHelpers {
  static void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.kFabColor,
        content: Text(
          message,
          style: AppTextStyles.appButton,
        ),
        duration: const Duration(
          seconds: 2,
        ),
      ),
    );
  }
}
