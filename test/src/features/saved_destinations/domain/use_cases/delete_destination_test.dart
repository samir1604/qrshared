import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_shared_app/src/core/domain/entities/failure.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/repositories/saved_destination_repository.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/use_cases/delete_destination.dart';

class MockSavedDestinationRepository extends Mock implements SavedDestinationRepository {}

void main() {
  late DeleteDestination useCase;
  late MockSavedDestinationRepository mockRepository;

  setUp(() {
    mockRepository = MockSavedDestinationRepository();
    useCase = DeleteDestination(mockRepository);
  });

  const tId = '1';

  test('should delete destination from the repository', () async {
    // arrange
    when(() => mockRepository.deleteDestination(any())).thenAnswer((_) async {});
    
    // act
    final result = await useCase(tId);
    
    // assert
    expect(result.isRight(), true);
    expect(result.getOrElse((l) => throw Exception()), unit);
    verify(() => mockRepository.deleteDestination(tId)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return DatabaseFailure when repository throws an exception', () async {
    // arrange
    when(() => mockRepository.deleteDestination(any())).thenThrow(Exception('test exception'));
    
    // act
    final result = await useCase(tId);
    
    // assert
    expect(result.isLeft(), true);
    result.fold(
      (l) => expect(l, isA<DatabaseFailure>()),
      (r) => fail('Should not return right'),
    );
    verify(() => mockRepository.deleteDestination(tId)).called(1);
  });
}
