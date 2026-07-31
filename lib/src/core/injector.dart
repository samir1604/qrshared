import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';
import 'package:qr_shared_app/src/core/services/services.dart';
import 'package:qr_shared_app/src/features/saved_destinations/saved_destinations.dart';

final GetIt di = GetIt.instance;

void configureDependencies() {
  di
    ..registerSingleton<TransferService>(TransferServiceImpl())
    ..registerLazySingleton<SavedDestinationRepository>(
      () => SavedDestinationRepositoryImpl(
        Hive.box<SavedDestinationHiveModel>('saved_destinations'),
      ),
    )
    ..registerLazySingleton(() => GetSavedDestinations(di()))
    ..registerLazySingleton(() => SaveDestination(di()))
    ..registerLazySingleton(() => DeleteDestination(di()));
}
