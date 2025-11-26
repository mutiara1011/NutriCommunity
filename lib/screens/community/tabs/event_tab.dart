import 'package:flutter/material.dart';

class EventTab extends StatelessWidget {
  const EventTab({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      {"title": "Events 1", "desc": "Deskripsi event"},
      {"title": "Events 2", "desc": "Deskripsi event"},
      {"title": "Events 3", "desc": "Deskripsi event"},
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final e = events[index];

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: const Color(0xFFF7EED4),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // TEXT
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e["title"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    e["desc"]!,
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),

              const Icon(Icons.arrow_forward_ios_rounded, size: 18),
            ],
          ),
        );
      },
    );
  }
}
