import 'package:fpdart/fpdart.dart';
import 'package:qr_shared_app/src/core/domain/entities/failure.dart';
import 'package:qr_shared_app/src/core/domain/use_cases/use_case.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/repositories/saved_destination_repository.dart';

class DeleteDestination implements UseCase<Unit, String> {
  DeleteDestination(this._repository);
  final SavedDestinationRepository _repository;

  @override
  Future<Either<Failure, Unit>> call(String id) async {
    try {
      await _repository.deleteDestination(id);
      return const Right(unit);
    } on Exception catch (e) {
      return Left(DatabaseFailure('Error al eliminar el destino: $e'));
    }
  }
}
