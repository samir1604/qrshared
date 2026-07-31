import 'package:hive_ce/hive.dart';
import 'package:qr_shared_app/src/features/saved_destinations/data/models/saved_destination_hive_model.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/repositories/saved_destination_repository.dart';

class SavedDestinationRepositoryImpl implements SavedDestinationRepository {
  SavedDestinationRepositoryImpl(this._box);

  final Box<SavedDestinationHiveModel> _box;

  @override
  List<SavedDestination> getAllDestinations() {
    return _box.values.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> saveDestination(SavedDestination destination) async {
    final model = destination.toHiveModel();
    await _box.put(model.id, model);
  }

  @override
  Future<void> deleteDestination(String id) async {
    await _box.delete(id);
  }
}
