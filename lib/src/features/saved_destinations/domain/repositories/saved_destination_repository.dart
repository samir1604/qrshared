import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';

abstract interface class SavedDestinationRepository {
  List<SavedDestination> getAllDestinations();
  Future<void> saveDestination(SavedDestination destination);
  Future<void> deleteDestination(String id);
}
