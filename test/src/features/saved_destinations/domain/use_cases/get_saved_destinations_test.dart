import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_shared_app/src/core/domain/entities/failure.dart';
import 'package:qr_shared_app/src/core/domain/use_cases/use_case.dart';
import 'package:qr_shared_app/src/core/domain/entities/qr_type.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/repositories/saved_destination_repository.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/use_cases/get_saved_destinations.dart';

class MockSavedDestinationRepository extends Mock
    implements SavedDestinationRepository {}

void main() {
  late GetSavedDestinations useCase;
  late MockSavedDestinationRepository mockRepository;

  setUp(() {
    mockRepository = MockSavedDestinationRepository();
    useCase = GetSavedDestinations(mockRepository);
  });

  final tDestinations = [
    SavedDestination(
      id: '1',
      name: 'test',
      type: QRType.payment,
      rawQrData: 'data',
      createdAt: DateTime.now(),
    ),
  ];

  test('should get destinations from the repository', () {
    // arrange
    when(() => mockRepository.getAllDestinations()).thenReturn(tDestinations);

    // act
    final result = useCase(const NoParams());

    // assert
    expect(result.isRight(), true);
    result.fold(
      (l) => fail('Should not return left'),
      (r) => expect(r, tDestinations),
    );
    verify(() => mockRepository.getAllDestinations()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });

  test('should return DatabaseFailure when repository throws an exception', () {
    // arrange
    when(
      () => mockRepository.getAllDestinations(),
    ).thenThrow(Exception('test exception'));

    // act
    final result = useCase(const NoParams());

    // assert
    expect(result.isLeft(), true);
    result.fold(
      (l) => expect(l, isA<DatabaseFailure>()),
      (r) => fail('Should not return right'),
    );
    verify(() => mockRepository.getAllDestinations()).called(1);
  });
}
