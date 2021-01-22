// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localNormalCart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NormalCartLocalAdapter extends TypeAdapter<NormalCartLocal> {
  @override
  final int typeId = 2;

  @override
  NormalCartLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NormalCartLocal(
      key: fields[0] as String,
      dateAdded: fields[1] as DateTime,
      productID: fields[3] as String,
      variantID: fields[2] as String,
      quantity: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NormalCartLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.dateAdded)
      ..writeByte(2)
      ..write(obj.variantID)
      ..writeByte(3)
      ..write(obj.productID)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NormalCartLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalCartLocal _$NormalCartLocalFromJson(Map<String, dynamic> json) {
  return NormalCartLocal(
    key: json['key'] as String,
    dateAdded: DateTime.parse(json['dateAdded'] as String),
    productID: json['productID'] as String,
    variantID: json['variantID'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$NormalCartLocalToJson(NormalCartLocal instance) =>
    <String, dynamic>{
      'key': instance.key,
      'dateAdded': instance.dateAdded.toIso8601String(),
      'variantID': instance.variantID,
      'productID': instance.productID,
      'quantity': instance.quantity,
    };
