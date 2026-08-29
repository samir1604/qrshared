import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_shared_app/src/core/domain/entities/failure.dart';
import 'package:qr_shared_app/src/core/domain/entities/qr_type.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/repositories/saved_destination_repository.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/use_cases/save_destination.dart';

class MockSavedDestinationRepository extends Mock
    implements SavedDestinationRepository {}

class FakeSavedDestination extends Fake implements SavedDestination {}

void main() {
  late SaveDestination useCase;
  late MockSavedDestinationRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(FakeSavedDestination());
  });

  setUp(() {
    mockRepository = MockSavedDestinationRepository();
    useCase = SaveDestination(mockRepository);
  });

  final tDestination = SavedDestination(
    id: '1',
    name: 'test',
    type: QRType.payment,
    rawQrData: 'data',
    createdAt: DateTime.now(),
  );

  test('should save destination to the repository', () async {
    // arrange
    when(() => mockRepository.saveDestination(any())).thenAnswer((_) async {});

    // act
    final result = await useCase(tDestination);

    // assert
    expect(result.isRight(), true);
    expect(result.getOrElse((l) => throw Exception()), unit);
    verify(() => mockRepository.saveDestination(tDestination)).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test(
    'should return DatabaseFailure when repository throws an exception',
    () async {
      // arrange
      when(
        () => mockRepository.saveDestination(any()),
      ).thenThrow(Exception('test exception'));

      // act
      final result = await useCase(tDestination);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (l) => expect(l, isA<DatabaseFailure>()),
        (r) => fail('Should not return right'),
      );
      verify(() => mockRepository.saveDestination(tDestination)).called(1);
    },
  );
}
