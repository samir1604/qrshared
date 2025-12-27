import 'package:flutter/material.dart';

class TorchButton extends StatelessWidget {
  const TorchButton({this.isOn, super.key, this.onPressed});

  final VoidCallback? onPressed;
  final bool? isOn;

  @override
  Widget build(BuildContext context) {
    if (isOn == null) {
      return const IconButton(
        icon: const Icon(Icons.no_flash_outlined, color: Colors.grey),
        onPressed: null,
      );
    }
    return IconButton(
      icon: Icon(
        isOn! ? Icons.flash_on : Icons.flash_off,
        color: isOn! ? Colors.yellow : Colors.white,
      ),
      onPressed: onPressed,
    );
  }
}
