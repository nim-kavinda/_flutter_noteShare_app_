import 'package:flutter/material.dart';
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
            )
          ],
        ),
      ),
    );
  }
}
