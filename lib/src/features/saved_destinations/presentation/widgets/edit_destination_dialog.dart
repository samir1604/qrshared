import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';
import 'package:qr_shared_app/src/features/saved_destinations/presentation/controllers/saved_destinations_controller.dart';

class EditDestinationDialog extends StatefulWidget {
  const EditDestinationDialog({
    super.key,
    required this.destination,
    required this.controller,
  });

  final SavedDestination destination;
  final SavedDestinationsController controller;

  @override
  State<EditDestinationDialog> createState() => _EditDestinationDialogState();
}

class _EditDestinationDialogState extends State<EditDestinationDialog> {
  late final TextEditingController _aliasController;
  late final TextEditingController _observationController;

  @override
  void initState() {
    super.initState();
    _aliasController = TextEditingController(text: widget.destination.alias);
    _observationController =
        TextEditingController(text: widget.destination.observation);
  }

  @override
  void dispose() {
    _aliasController.dispose();
    _observationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Destino'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _aliasController,
            decoration: const InputDecoration(
              labelText: 'Alias (Ej. Mamá, Juan)',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _observationController,
            decoration: const InputDecoration(
              labelText: 'Observación (Opcional)',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () async {
            final updatedDestination = widget.destination.copyWith(
              alias: _aliasController.text.trim().isEmpty
                  ? null
                  : _aliasController.text.trim(),
              observation: _observationController.text.trim().isEmpty
                  ? null
                  : _observationController.text.trim(),
            );

            await widget.controller.save(updatedDestination);
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          },
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
