import 'package:flutter/material.dart';

class EducationDetailScreen extends StatelessWidget {
  final String title;
  final String desc;

  const EducationDetailScreen({
    super.key,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFBEA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF398A57),
        title: Text(title),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(desc, style: const TextStyle(fontSize: 16, height: 1.5)),
      ),
    );
  }
}
