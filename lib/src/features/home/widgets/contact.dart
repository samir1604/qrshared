import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';

class Contact extends StatelessWidget {
  const Contact({super.key, this.onPress});
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.grey.shade100, // Fondo gris muy claro para diferenciar
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Icon(
          Icons.bug_report_outlined,
          color: Colors.blue.shade900,
          size: 30,
        ),
        const SizedBox(height: 12),
        Text(
          StringConstants.anyProblem,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        Text(StringConstants.contactText,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: onPress,
          icon: const Icon(Icons.email_outlined),
          label: Text(StringConstants.authorEmail),
          style: TextButton.styleFrom(
            foregroundColor: Colors.blue.shade900,
            backgroundColor: Colors.white,
            side: BorderSide(color: Colors.blue.shade900),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    ),
  );
}
