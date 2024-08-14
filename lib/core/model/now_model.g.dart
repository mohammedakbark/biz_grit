// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NowModelAdapter extends TypeAdapter<NowModel> {
  @override
  final int typeId = 4;

  @override
  NowModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NowModel(
      lastRecordDate: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NowModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.lastRecordDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NowModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
