// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodModelHiveAdapter extends TypeAdapter<FoodModelHive> {
  @override
  final int typeId = 4;

  @override
  FoodModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodModelHive(
      name: fields[0] as String,
      confidence: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FoodModelHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.confidence);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
