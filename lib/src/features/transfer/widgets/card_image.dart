import 'package:flutter/material.dart';

class CardImage extends StatelessWidget {
  const CardImage({required this.assetImage, super.key, this.width});

  final String assetImage;
  final double? width;

  @override
  Widget build(BuildContext context) =>
      Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white),
        ),
        padding: const EdgeInsets.all(6),
        child: Image.asset(
          assetImage,
          fit: BoxFit.cover,
        ),
      );
}
