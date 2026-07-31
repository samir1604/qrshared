// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_destination_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedDestinationHiveModelAdapter
    extends TypeAdapter<SavedDestinationHiveModel> {
  @override
  final typeId = 1;

  @override
  SavedDestinationHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedDestinationHiveModel(
      id: fields[0] as String,
      name: fields[1] as String,
      alias: fields[2] as String?,
      typeIndex: (fields[3] as num).toInt(),
      rawQrData: fields[4] as String,
      phone: fields[5] as String?,
      accountOrProviderNumber: fields[6] as String?,
      observation: fields[7] as String?,
      createdAt: fields[8] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SavedDestinationHiveModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.alias)
      ..writeByte(3)
      ..write(obj.typeIndex)
      ..writeByte(4)
      ..write(obj.rawQrData)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.accountOrProviderNumber)
      ..writeByte(7)
      ..write(obj.observation)
      ..writeByte(8)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedDestinationHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
