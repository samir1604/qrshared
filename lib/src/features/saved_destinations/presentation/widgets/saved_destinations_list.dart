import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/features/saved_destinations/saved_destinations.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SavedDestinationsList extends StatelessWidget {
  const SavedDestinationsList({
    super.key,
    required this.state,
    required this.filteredList,
    required this.controller,
  });

  final AsyncState<List<SavedDestination>> state;
  final List<SavedDestination> filteredList;
  final SavedDestinationsController controller;

  @override
  Widget build(BuildContext context) {
    if (state is AsyncLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is AsyncError) {
      return Center(
        child: Text(
          'Error: ${(state as AsyncError).error}',
          style: const TextStyle(color: Colors.red),
        ),
      );
    }

    if (filteredList.isEmpty) {
      return const Center(
        child: Text('No se encontraron destinos.'),
      );
    }

    return ListView.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        final destination = filteredList[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(destination.alias ?? destination.name),
            subtitle: Text(
              destination.phone ??
                  destination.accountOrProviderNumber ??
                  'Desconocido',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: () {
                    // Lógica para editar (próximamente)
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () => controller.delete(destination.id),
                ),
              ],
            ),
            onTap: () {
              // Lógica para realizar transferencia con intent (próximamente)
            },
          ),
        );
      },
    );
  }
}
