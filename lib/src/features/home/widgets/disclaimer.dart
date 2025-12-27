import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';

class Disclaimer extends StatelessWidget {
  const Disclaimer({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.blue.withValues(alpha: .05),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blue.shade100),
    ),
    child: Text(
      StringConstants.privacy,

      style: const TextStyle(
        fontSize: 13,
        color: Colors.blueGrey,
      ),
    ),
  );
}
