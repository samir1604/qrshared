import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';
import 'package:qr_shared_app/src/core/extensions/buildcontext_extension.dart';

class ScannerError extends StatelessWidget {
  const ScannerError({
    required this.message,
    super.key,
    this.onPressed,
    this.isCameraError = false,
  });

  final String message;
  final VoidCallback? onPressed;
  final bool isCameraError;

  @override
  Widget build(BuildContext context) {
    final errorImage = isCameraError
        ? AssetConstants.cameraError
        : AssetConstants.qrBadCode;
    final imageWidth =
        context.effectiveWidth * (context.isSmallWidth ? .5 : .7);

    return SizedBox.expand(
      child: ColoredBox(
        color: Colors.blue.shade900,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  errorImage,
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
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      StringConstants.tryAgain,
                      style: Theme.of(
                        context,
                      ).textTheme.titleMedium?.copyWith(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
