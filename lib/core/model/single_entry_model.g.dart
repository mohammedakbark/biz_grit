// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'single_entry_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SingleEntryModelAdapter extends TypeAdapter<SingleEntryModel> {
  @override
  final int typeId = 2;

  @override
  SingleEntryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SingleEntryModel(
      id: fields[0] as String,
      sales: fields[4] as String,
      margin: fields[3] as String,
      quantity: fields[2] as String,
      title: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SingleEntryModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.margin)
      ..writeByte(4)
      ..write(obj.sales);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SingleEntryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
