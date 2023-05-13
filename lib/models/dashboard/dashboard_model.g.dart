// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DashboardModelAdapter extends TypeAdapter<DashboardModel> {
  @override
  final int typeId = 4;

  @override
  DashboardModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DashboardModel(
      type: fields[0] as CategoryType,
      amount: fields[1] as double,
    )..id = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, DashboardModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
