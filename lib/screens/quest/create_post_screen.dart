import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/quest_service.dart';

class CreatePostScreen extends StatefulWidget {
  final File image;
  final String questTitle;

  const CreatePostScreen({
    super.key,
    required this.image,
    required this.questTitle,
  });

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final captionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Buat Postingan"),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: captionController,
              decoration: const InputDecoration(
                labelText: "Caption",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(widget.image, height: 220),
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () {
                QuestService.addPost(captionController.text, widget.image);

                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 14,
                ),
              ),
              child: const Text(
                "Posting",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
