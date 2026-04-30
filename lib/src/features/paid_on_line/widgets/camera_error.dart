import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';
import 'package:qr_shared_app/src/core/extensions/buildcontext_extension.dart';

class CameraError extends StatelessWidget {
  const CameraError({required this.message, super.key, this.onPressed});

  final String message;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final imageWidth =
        context.effectiveWidth * (context.isSmallWidth ? .5 : .7);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AssetConstants.cameraError,
              width: imageWidth,
              cacheWidth: (imageWidth * context.devicePixelRatio).toInt(),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(StringConstants.tryAgain, style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: Colors.black),),
            ),
          ],
        ),
      ),
    );
  }
}
