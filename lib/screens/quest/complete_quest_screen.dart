import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../services/quest_service.dart';
import 'create_post_screen.dart';

class CompleteQuestScreen extends StatefulWidget {
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
  State<CompleteQuestScreen> createState() => _CompleteQuestScreenState();
}

class _CompleteQuestScreenState extends State<CompleteQuestScreen> {
  double? aspectRatio;

  @override
  void initState() {
    super.initState();
    _loadImageSize();
  }

  Future<void> _loadImageSize() async {
    final bytes = await widget.image.readAsBytes();
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    final img = frame.image;

    setState(() {
      aspectRatio = img.width / img.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_rounded),
                    iconSize: 26,
                    color: Colors.brown.shade800,
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // TITLE (rapat & modern)
              Text(
                "Quest Selesai!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: Colors.brown.shade800,
                ),
              ),

              const SizedBox(height: 6),

              Text(
                widget.questTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.brown.shade600,
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 18),

              if (aspectRatio == null)
                const Center(child: CircularProgressIndicator())
              else
                Flexible(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: AspectRatio(
                        aspectRatio: aspectRatio!,
                        child: Image.file(widget.image, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 18),

              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 18,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCF5D6),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  "+${widget.xp} XP",
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    QuestService.addXp(widget.xp);
                    QuestService.addHistory(widget.questTitle, true, widget.xp);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CreatePostScreen(
                          image: widget.image,
                          questTitle: widget.questTitle,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade600,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Buat Postingan",
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              TextButton(
                onPressed: () {
                  QuestService.addXp(widget.xp);
                  QuestService.addHistory(widget.questTitle, true, widget.xp);
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text(
                  "Lewati",
                  style: TextStyle(fontSize: 15, color: Colors.brown.shade700),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
