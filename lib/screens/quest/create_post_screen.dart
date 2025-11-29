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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green.shade600,
        title: const Text(
          "Buat Postingan",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            22,
            22,
            22,
            MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Label
              Text(
                "Tambahkan Caption",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown.shade800,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: TextField(
                  controller: captionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "Tulis sesuatu...",
                    hintStyle: TextStyle(color: Colors.grey.shade500),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              Text(
                "Foto Quest",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.brown.shade800,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.file(
                    widget.image,
                    height: 240,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    QuestService.addPost(captionController.text, widget.image);

                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 3,
                  ),
                  child: const Text(
                    "Posting",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
