import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/quest_service.dart';
import 'create_post_screen.dart';

class CompleteQuestScreen extends StatelessWidget {
  final String questTitle;
  final int xp;
  final File image;

  const CompleteQuestScreen({
    super.key,
    required this.questTitle,
    required this.xp,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            const Text(
              "Quest Completed!",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(image, height: 240),
            ),

            const SizedBox(height: 20),

            Text(
              "+$xp XP",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                // simpan history
                QuestService.addXp(xp);
                QuestService.addHistory(questTitle, true, xp);

                // lanjut untuk membuat postingan
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        CreatePostScreen(image: image, questTitle: questTitle),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              child: const Text(
                "Buat Postingan",
                style: TextStyle(color: Colors.white),
              ),
            ),

            TextButton(
              onPressed: () {
                QuestService.addXp(xp);
                QuestService.addHistory(questTitle, true, xp);
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Lewati"),
            ),
          ],
        ),
      ),
    );
  }
}
