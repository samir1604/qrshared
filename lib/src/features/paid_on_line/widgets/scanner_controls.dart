import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';
import 'package:qr_shared_app/src/core/extensions/extensions.dart';
import 'package:qr_shared_app/src/features/paid_on_line/paid_on_line.dart';

class ScannerControls extends StatelessWidget {
  const ScannerControls({
    super.key,
    this.isTorchOn,
    this.onGalleryClick,
    this.onTorchClick,
    this.isSaveDestinationOn = false,
    this.onSaveDestinationToggle,
  });

  final bool? isTorchOn;
  final VoidCallback? onGalleryClick;
  final VoidCallback? onTorchClick;
  final bool isSaveDestinationOn;
  final ValueChanged<bool>? onSaveDestinationToggle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: context.systemTopPadding + context.spacingMedium,
          left: 20,
          child: ImageButton(onPressed: onGalleryClick),
        ),
        Positioned(
          bottom: context.systemTopPadding + context.spacingMedium,
          left: 24,
          right: 24,
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onSaveDestinationToggle != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Guardar destino',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: isSaveDestinationOn,
                        onChanged: onSaveDestinationToggle,
                        activeThumbColor: Colors.blue.shade300,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
                InformationText(
                  text: StringConstants.scanText,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: context.systemTopPadding + context.spacingMedium,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.black.withValues(alpha: .5),
            child: TorchButton(
              isOn: isTorchOn,
              onPressed: onTorchClick,
            ),
          ),
        ),
      ],
    );
  }
}
