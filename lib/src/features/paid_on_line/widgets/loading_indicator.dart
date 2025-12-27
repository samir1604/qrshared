import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: Colors.black,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(
            color: Colors.blue,
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            'Iniciando cámara...',
            style: TextStyle(
              color: Colors.white.withValues(
                alpha: .7,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
