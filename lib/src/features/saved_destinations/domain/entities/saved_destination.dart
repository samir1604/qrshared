import 'package:equatable/equatable.dart';
import 'package:qr_shared_app/src/core/domain/entities/qr_type.dart';

class SavedDestination extends Equatable {
  final String id;
  final String name;
  final String? alias;
  final QRType type;
  final String rawQrData;
  final String? phone;
  final String? accountOrProviderNumber;
  final String? observation;
  final DateTime createdAt;

  const SavedDestination({
    required this.id,
    required this.name,
    this.alias,
    required this.type,
    required this.rawQrData,
    this.phone,
    this.accountOrProviderNumber,
    this.observation,
    required this.createdAt,
  });

  SavedDestination copyWith({
    String? id,
    String? name,
    String? alias,
    QRType? type,
    String? rawQrData,
    String? phone,
    String? accountOrProviderNumber,
    String? observation,
    DateTime? createdAt,
  }) {
    return SavedDestination(
      id: id ?? this.id,
      name: name ?? this.name,
      alias: alias ?? this.alias,
      type: type ?? this.type,
      rawQrData: rawQrData ?? this.rawQrData,
      phone: phone ?? this.phone,
      accountOrProviderNumber:
          accountOrProviderNumber ?? this.accountOrProviderNumber,
      observation: observation ?? this.observation,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    alias,
    type,
    rawQrData,
    phone,
    accountOrProviderNumber,
    observation,
    createdAt,
  ];
}
