// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model_hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultModelHiveAdapter extends TypeAdapter<ResultModelHive> {
  @override
  final int typeId = 2;

  @override
  ResultModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultModelHive(
      resultID: fields[0] as String,
      timestamp: fields[1] as DateTime,
      userID: fields[2] as String,
      foodPicURL: fields[3] as String,
      identifiedFoodNutrients: (fields[4] as List?)?.cast<FoodNutrientHive>(),
    );
  }

  @override
  void write(BinaryWriter writer, ResultModelHive obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.resultID)
      ..writeByte(1)
      ..write(obj.timestamp)
      ..writeByte(2)
      ..write(obj.userID)
      ..writeByte(3)
      ..write(obj.foodPicURL)
      ..writeByte(4)
      ..write(obj.identifiedFoodNutrients);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
