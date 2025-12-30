import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/constants/constants.dart';
import 'package:qr_shared_app/src/core/extensions/extensions.dart';

class ScanQrButton extends StatelessWidget {
  const ScanQrButton({this.onTap, super.key});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: context.getSize.width * .7,
      padding: EdgeInsets.symmetric(
        vertical: context.isSmallWidth ? 14 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.camera_alt,
            color: Colors.blue.shade900,
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              StringConstants.scanQr,
              style: TextStyle(
                color: Colors.blue.shade900,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
