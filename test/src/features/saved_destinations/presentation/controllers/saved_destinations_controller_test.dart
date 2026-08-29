import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_shared_app/src/core/domain/use_cases/use_case.dart';
import 'package:qr_shared_app/src/core/domain/entities/qr_type.dart';
import 'package:qr_shared_app/src/features/saved_destinations/saved_destinations.dart';
import 'package:signals_flutter/signals_flutter.dart';

class MockGetSavedDestinations extends Mock
    implements UseCase<List<SavedDestination>, NoParams> {}

class MockSaveDestination extends Mock
    implements UseCase<Unit, SavedDestination> {}

class MockDeleteDestination extends Mock implements UseCase<Unit, String> {}

void main() {
  group('SavedDestinationsController', () {
    late MockGetSavedDestinations mockGetDestinations;
    late MockSaveDestination mockSaveDestination;
    late MockDeleteDestination mockDeleteDestination;
    late SavedDestinationsController controller;

    final dummyDestination = SavedDestination(
      id: '1',
      name: 'Test Destination',
      type: QRType.payment,
      rawQrData: 'qr_data',
      createdAt: DateTime.now(),
    );

    setUpAll(() {
      registerFallbackValue(dummyDestination);
      registerFallbackValue(const NoParams());
    });

    setUp(() {
      mockGetDestinations = MockGetSavedDestinations();
      mockSaveDestination = MockSaveDestination();
      mockDeleteDestination = MockDeleteDestination();

      // Configure default success response for loading destinations
      when(
        () => mockGetDestinations(any()),
      ).thenAnswer((_) async => const Right([]));

      // We instantiate the controller here. The constructor automatically calls loadDestinations()
      controller = SavedDestinationsController(
        mockGetDestinations,
        mockSaveDestination,
        mockDeleteDestination,
      );
    });

    test('initial state loads destinations successfully', () async {
      // Allow the async constructor loading to finish
      await Future.delayed(Duration.zero);

      expect(
        controller.destinations.value,
        isA<AsyncData<List<SavedDestination>>>(),
      );
      verify(() => mockGetDestinations(any())).called(1);
    });

    test('save() calls save usecase and reloads destinations', () async {
      when(
        () => mockSaveDestination(any()),
      ).thenAnswer((_) async => const Right(unit));

      await controller.save(dummyDestination);

      verify(() => mockSaveDestination(dummyDestination)).called(1);
      // It is called once during init, and once after saving
      verify(() => mockGetDestinations(any())).called(2);
    });

    test('delete() calls delete usecase and reloads destinations', () async {
      when(
        () => mockDeleteDestination(any()),
      ).thenAnswer((_) async => const Right(unit));

      await controller.delete('1');

      verify(() => mockDeleteDestination('1')).called(1);
      // It is called once during init, and once after deleting
      verify(() => mockGetDestinations(any())).called(2);
    });
  });
}
