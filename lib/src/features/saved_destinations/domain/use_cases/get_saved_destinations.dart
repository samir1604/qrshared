import 'package:fpdart/fpdart.dart';
import 'package:qr_shared_app/src/core/domain/entities/failure.dart';
import 'package:qr_shared_app/src/core/domain/use_cases/use_case.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/repositories/saved_destination_repository.dart';

class GetSavedDestinations implements UseCase<List<SavedDestination>, NoParams> {
  const GetSavedDestinations(this._repository);
  final SavedDestinationRepository _repository;

  @override
  Either<Failure, List<SavedDestination>> call(NoParams params) {
    try {
      final destinations = _repository.getAllDestinations();
      // Podemos aplicar reglas de negocio aquí si fuera necesario
      return Right(destinations);
    } on Exception catch (e) {
      return Left(DatabaseFailure('Error al recuperar los destinos: $e'));
    }
  }
}
