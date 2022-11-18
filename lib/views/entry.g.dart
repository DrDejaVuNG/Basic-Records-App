// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordAdapter extends TypeAdapter<Record> {
  @override
  final int typeId = 0;

  @override
  Record read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Record(
      id: fields[0] as String,
      name: fields[1] as String,
      sysName: fields[2] as String,
      serialNo: fields[3] as String,
      sysType: fields[4] as String,
      selectedGender: fields[5] as String,
      fault: fields[6] as String,
      contact: fields[7] as String,
      engrName: fields[8] as String,
      createdAt: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Record obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sysName)
      ..writeByte(3)
      ..write(obj.serialNo)
      ..writeByte(4)
      ..write(obj.sysType)
      ..writeByte(5)
      ..write(obj.selectedGender)
      ..writeByte(6)
      ..write(obj.fault)
      ..writeByte(7)
      ..write(obj.contact)
      ..writeByte(8)
      ..write(obj.engrName)
      ..writeByte(9)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
