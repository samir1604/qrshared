import 'package:fpdart/fpdart.dart';
import 'package:qr_shared_app/src/core/domain/use_cases/use_case.dart';
import 'package:qr_shared_app/src/features/saved_destinations/saved_destinations.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SavedDestinationsController {
  SavedDestinationsController(
    this._getDestinations,
    this._saveDestination,
    this._deleteDestination,
  ) {
    // Cargar destinos al instanciar el controlador
    loadDestinations().ignore();
  }

  final UseCase<List<SavedDestination>, NoParams> _getDestinations;
  final UseCase<Unit, SavedDestination> _saveDestination;
  final UseCase<Unit, String> _deleteDestination;

  // Estado reactivo principal
  late final FlutterSignal<AsyncState<List<SavedDestination>>> destinations =
      signal<AsyncState<List<SavedDestination>>>(const AsyncLoading());

  // Estado para la barra de búsqueda en tiempo real
  late final FlutterSignal<String> searchQuery = signal<String>('');

  // Estado para manejar errores que deben mostrarse en la UI (Snackbars)
  late final FlutterSignal<String?> errorMessage = signal<String?>(null);

  // Computed: Reacciona automáticamente cuando cambian 'destinations' o 'searchQuery'
  late final FlutterComputed<List<SavedDestination>> filteredDestinations =
      computed(() {
        final state = destinations();

        // Si tenemos datos, aplicamos el filtro
        if (state is AsyncData<List<SavedDestination>>) {
          final query = searchQuery().toLowerCase();
          if (query.isEmpty) return state.value;

          return state.value.where((d) {
            final aliasMatch = d.alias?.toLowerCase().contains(query) ?? false;
            final nameMatch = d.name.toLowerCase().contains(query);
            return aliasMatch || nameMatch;
          }).toList();
        }

        // Si está cargando o en error, devolvemos lista vacía
        return <SavedDestination>[];
      });

  Future<void> loadDestinations() async {
    destinations.value = const AsyncLoading();

    final result = await _getDestinations(const NoParams());

    result.fold(
      (failure) {
        destinations.value = AsyncError(failure.message, StackTrace.empty);
      },
      (data) {
        destinations.value = AsyncData(data);
      },
    );
  }

  Future<void> save(SavedDestination destination) async {
    final result = await _saveDestination(destination);

    await result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (_) async {
        // Al guardar exitosamente, recargamos la lista
        await loadDestinations();
      },
    );
  }

  Future<void> delete(String id) async {
    final result = await _deleteDestination(id);

    await result.fold(
      (failure) {
        errorMessage.value = failure.message;
      },
      (_) async {
        // Al eliminar exitosamente, recargamos la lista
        await loadDestinations();
      },
    );
  }
}
