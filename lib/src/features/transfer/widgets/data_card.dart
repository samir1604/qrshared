import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/extensions/buildcontext_extension.dart';

class DataCard extends StatelessWidget {
  const DataCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.onCopy,
    super.key,
  });

  final String title;
  final String value;
  final IconData icon;
  final VoidCallback onCopy;

  @override
  Widget build(BuildContext context) {
    final iconSize = context.isSmallWidth ? 20.0 : 24.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacingMedium,
            vertical: context.spacingSmall,
          ),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.blue.shade600, size: iconSize),
              const SizedBox(width: 10),
              Expanded(
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Text(
                    value,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.copy,
                  color: Colors.blue.shade900,
                  size: iconSize,
                ),
                onPressed: onCopy,
                tooltip: 'Copiar',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
