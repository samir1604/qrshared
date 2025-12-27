import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  const TextSection({required this.title, required this.content, super.key});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 15,
            height: 1.5, // Interlineado para mejor lectura
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}
