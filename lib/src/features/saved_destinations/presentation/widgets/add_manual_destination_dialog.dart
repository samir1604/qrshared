import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/domain/entities/qr_type.dart';
import 'package:qr_shared_app/src/core/injector.dart';
import 'package:qr_shared_app/src/features/saved_destinations/saved_destinations.dart';

class AddManualDestinationDialog extends StatefulWidget {
  const AddManualDestinationDialog({super.key});

  @override
  State<AddManualDestinationDialog> createState() =>
      _AddManualDestinationDialogState();
}

class _AddManualDestinationDialogState
    extends State<AddManualDestinationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _aliasController = TextEditingController();
  final _numberController = TextEditingController();
  final SavedDestinationsController _controller =
      di<SavedDestinationsController>();

  @override
  void dispose() {
    _aliasController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Future<void> _onSave() async {
    if (_formKey.currentState?.validate() ?? false) {
      final alias = _aliasController.text.trim();
      final number = _numberController.text.trim();

      final destination = SavedDestination(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: 'Transferencia Manual',
        alias: alias.isEmpty ? null : alias,
        type: QRType.transfer,
        rawQrData: '',
        accountOrProviderNumber: number,
        createdAt: DateTime.now(),
      );

      await _controller.save(destination);
      if (mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Añadir destino'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _aliasController,
              decoration: const InputDecoration(
                labelText: 'Alias (Opcional)',
                hintText: 'Ej. Juan Pérez',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _numberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Número de tarjeta / cuenta',
                hintText: 'Ingrese el número',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Requerido';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _onSave,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
