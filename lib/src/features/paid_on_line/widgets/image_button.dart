import 'package:flutter/material.dart';

class ImageButton extends StatelessWidget {
  const ImageButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black.withValues(alpha: .5),
      child: IconButton(
        icon: const Icon(Icons.image, color: Colors.white),
        onPressed: onPressed,
      ),
    );
  }
}
