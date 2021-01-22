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
      productID: fields[2] as String,
      variantID: fields[1] as String,
      quantity: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NormalCartLocal obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.variantID)
      ..writeByte(2)
      ..write(obj.productID)
      ..writeByte(3)
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
    productID: json['productID'] as String,
    variantID: json['variantID'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$NormalCartLocalToJson(NormalCartLocal instance) =>
    <String, dynamic>{
      'key': instance.key,
      'variantID': instance.variantID,
      'productID': instance.productID,
      'quantity': instance.quantity,
    };
