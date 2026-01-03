import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/extensions/extensions.dart';

class CardImage extends StatelessWidget {
  const CardImage({
    required this.assetImage,
    super.key,
    this.width,
    this.height,
  });

  final String assetImage;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.white),
    ),
    padding: const EdgeInsets.all(6),
    child: Image.asset(
      assetImage,
      fit: BoxFit.cover,
      cacheWidth: width != null
          ? (width! * context.devicePixelRatio).toInt()
          : null,
      cacheHeight: height != null
          ? (height! * context.devicePixelRatio).toInt()
          : null,
    ),
  );
}
