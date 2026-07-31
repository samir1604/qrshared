import 'package:fpdart/fpdart.dart';
import 'package:qr_shared_app/src/core/domain/entities/failure.dart';
import 'package:qr_shared_app/src/core/domain/use_cases/use_case.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/repositories/saved_destination_repository.dart';

class SaveDestination implements UseCase<Unit, SavedDestination> {
  const SaveDestination(this._repository);
  final SavedDestinationRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(SavedDestination destination) async {
    try {
      await _repository.saveDestination(destination);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(DatabaseFailure('Error al guardar el destino: $e'));
    }
  }
}
