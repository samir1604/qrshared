import 'package:flutter/material.dart';
import 'package:qr_shared_app/src/core/injector.dart';
import 'package:qr_shared_app/src/features/saved_destinations/saved_destinations.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SavedDestinationsPage extends StatelessWidget {
  const SavedDestinationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Inyectamos el controlador (Singleton)
    final controller = di<SavedDestinationsController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Destinos'),
      ),
      body: Column(
        children: [
          // Barra de búsqueda
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Buscar destinos...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => controller.searchQuery.value = value,
            ),
          ),

          // Contenido principal de la lista reactivo con Watch
          Expanded(
            child: SignalBuilder(
              builder: (context) {
                final state = controller.destinations.value;
                final filteredList = controller.filteredDestinations.value;
                return SavedDestinationsList(
                  state: state,
                  filteredList: filteredList,
                  controller: controller,
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (_) => const AddDestinationOptionsSheet(),
          ).ignore();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
