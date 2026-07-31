import 'package:hive_ce/hive.dart';
import 'package:qr_shared_app/src/core/domain/entities/qr_type.dart';
import 'package:qr_shared_app/src/features/saved_destinations/domain/entities/saved_destination.dart';

part 'saved_destination_hive_model.g.dart';

@HiveType(typeId: 1)
class SavedDestinationHiveModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  String? alias;

  @HiveField(3)
  final int typeIndex;

  @HiveField(4)
  final String rawQrData;

  @HiveField(5)
  final String? phone;

  @HiveField(6)
  final String? accountOrProviderNumber;

  @HiveField(7)
  String? observation;

  @HiveField(8)
  final DateTime createdAt;

  SavedDestinationHiveModel({
    required this.id,
    required this.name,
    this.alias,
    required this.typeIndex,
    required this.rawQrData,
    this.phone,
    this.accountOrProviderNumber,
    this.observation,
    required this.createdAt,
  });
}

extension SavedDestinationHiveModelX on SavedDestinationHiveModel {
  SavedDestination toEntity() {
    return SavedDestination(
      id: id,
      name: name,
      alias: alias,
      type: QRType.values[typeIndex],
      rawQrData: rawQrData,
      phone: phone,
      accountOrProviderNumber: accountOrProviderNumber,
      observation: observation,
      createdAt: createdAt,
    );
  }
}

extension SavedDestinationX on SavedDestination {
  SavedDestinationHiveModel toHiveModel() {
    return SavedDestinationHiveModel(
      id: id,
      name: name,
      alias: alias,
      typeIndex: type.index,
      rawQrData: rawQrData,
      phone: phone,
      accountOrProviderNumber: accountOrProviderNumber,
      observation: observation,
      createdAt: createdAt,
    );
  }
}
