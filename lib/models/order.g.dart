// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineOrderAdapter extends TypeAdapter<OfflineOrder> {
  @override
  final int typeId = 2;

  @override
  OfflineOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineOrder(
      name: fields[0] as String,
      price: fields[1] as int,
      id: fields[2] as String,
      discount: fields[3] as String,
      imageUrl: fields[4] as String,
      imageHash: fields[5] as String,
      count: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineOrder obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.discount)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.imageHash)
      ..writeByte(6)
      ..write(obj.count);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
