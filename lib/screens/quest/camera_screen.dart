import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'complete_quest_screen.dart';

class CameraScreen extends StatefulWidget {
  final String questTitle;
  final int xp;

  const CameraScreen({super.key, required this.questTitle, required this.xp});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final picker = ImagePicker();

  Future<void> openCamera() async {
    final picked = await picker.pickImage(source: ImageSource.camera);

    if (!mounted) return;

    if (picked != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CompleteQuestScreen(
            questTitle: widget.questTitle,
            xp: widget.xp,
            image: File(picked.path),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    openCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("Opening camera...")));
  }
}
