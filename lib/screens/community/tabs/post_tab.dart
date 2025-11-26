import 'package:flutter/material.dart';

class PostTab extends StatelessWidget {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF7EED4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: Color(0xFF2F7F3F),
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "mutiaraas",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "20 September 2025 13.27 • Serang",
                        style: TextStyle(fontSize: 11, color: Colors.black54),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const Text(
                "Saya telah menyelesaikan quest Quest Satu : blablabla",
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 12),

              // Image placeholder
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Gambar 1",
                  style: TextStyle(color: Colors.black54),
                ),
              ),

              const SizedBox(height: 14),

              // ACTION BUTTONS
              Row(
                children: const [
                  Icon(Icons.thumb_up_alt_outlined, size: 22),
                  SizedBox(width: 12),
                  Icon(Icons.mode_comment_outlined, size: 22),
                  SizedBox(width: 12),
                  Icon(Icons.share_outlined, size: 22),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
