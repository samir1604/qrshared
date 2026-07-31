import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/features/saved_destinations/saved_destinations.dart';

class AddDestinationOptionsSheet extends StatelessWidget {
  const AddDestinationOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.qr_code_scanner),
            title: const Text('Escanear código QR'),
            onTap: () {
              Navigator.pop(context);
              // Lógica de escaneo (próximamente)
            },
          ),
          ListTile(
            leading: const Icon(Icons.edit_document),
            title: const Text('Añadir manualmente (Transferencia)'),
            onTap: () {
              Navigator.pop(context);
              showDialog<void>(
                context: context,
                builder: (_) => const AddManualDestinationDialog(),
              ).ignore();
            },
          ),
        ],
      ),
    );
  }
}
