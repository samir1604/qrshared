import 'package:flutter_test/flutter_test.dart';
import 'package:hive_ce/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_shared_app/src/core/domain/entities/qr_type.dart';
import 'package:qr_shared_app/src/features/saved_destinations/data/models/saved_destination_hive_model.dart';
import 'package:qr_shared_app/src/features/saved_destinations/data/repositories/saved_destination_repository_impl.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';

class MockBox extends Mock implements Box<SavedDestinationHiveModel> {}

class FakeSavedDestinationHiveModel extends Fake
    implements SavedDestinationHiveModel {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeSavedDestinationHiveModel());
  });

  group('SavedDestinationRepositoryImpl', () {
    late MockBox mockBox;
    late SavedDestinationRepositoryImpl repository;
    late DateTime testDate;

    setUp(() {
      mockBox = MockBox();
      repository = SavedDestinationRepositoryImpl(mockBox);
      testDate = DateTime(2026, 1, 1);
    });

    test('getAllDestinations returns list of SavedDestination entities', () {
      // Arrange
      final model1 = SavedDestinationHiveModel(
        id: '1',
        name: 'Test 1',
        typeIndex: QRType.transfer.index,
        rawQrData: 'data1',
        createdAt: testDate,
      );
      final model2 = SavedDestinationHiveModel(
        id: '2',
        name: 'Test 2',
        typeIndex: QRType.payment.index,
        rawQrData: 'data2',
        createdAt: testDate,
      );

      when(() => mockBox.values).thenReturn([model1, model2]);

      // Act
      final result = repository.getAllDestinations();

      // Assert
      expect(result.length, 2);
      expect(result[0].id, '1');
      expect(result[0].name, 'Test 1');
      expect(result[0].type, QRType.transfer);
      expect(result[1].id, '2');
      expect(result[1].name, 'Test 2');
      expect(result[1].type, QRType.payment);
      verify(() => mockBox.values).called(1);
    });

    test('saveDestination saves a model to the box', () async {
      // Arrange
      final entity = SavedDestination(
        id: '1',
        name: 'Test',
        type: QRType.transfer,
        rawQrData: 'data',
        createdAt: testDate,
      );

      when(() => mockBox.put(any(), any())).thenAnswer((_) async {});

      // Act
      await repository.saveDestination(entity);

      // Assert
      verify(() => mockBox.put('1', any())).called(1);
    });

    test('deleteDestination deletes a model from the box', () async {
      // Arrange
      when(() => mockBox.delete(any())).thenAnswer((_) async {});

      // Act
      await repository.deleteDestination('1');

      // Assert
      verify(() => mockBox.delete('1')).called(1);
    });
  });
}
