import 'package:flutter/material.dart';
import 'package:note_app/utils/router.dart';
import 'package:note_app/utils/text_style.dart';
import 'package:note_app/widgets/notes_to_to_card.dart';
import 'package:note_app/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NoteSphere',
          style: AppTextStyles.appTitle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            const ProgressCard(
              completedTask: 4,
              totalTask: 5,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    // go to the notes page
                    AppRouter.router.push("/notes");
                  },
                  child: const NotesToDoCards(
                    title: "Notes",
                    description: "3 notes",
                    icon: Icons.bookmark_add_outlined,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // go to the to do list page
                    AppRouter.router.push("/todos");
                  },
                  child: const NotesToDoCards(
                    title: "To Do List",
                    description: "3 Task",
                    icon: Icons.today_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Progress",
                  style: AppTextStyles.appSubtitle,
                ),
                Text(
                  "See All",
                  style: AppTextStyles.appButton,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
