// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrient_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodNutrientHiveAdapter extends TypeAdapter<FoodNutrientHive> {
  @override
  final int typeId = 3;

  @override
  FoodNutrientHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodNutrientHive(
      name: fields[0] as String,
      grams: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, FoodNutrientHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.grams);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodNutrientHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
