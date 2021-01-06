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
      productId: fields[0] as String,
      variantId: fields[1] as String,
      quantity: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, NormalCartLocal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.variantId)
      ..writeByte(2)
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
    productId: json['productId'] as String,
    variantId: json['varientId'] as String,
    quantity: json['quantity'] as int,
  );
}

Map<String, dynamic> _$NormalCartLocalToJson(NormalCartLocal instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'varientId': instance.variantId,
      'quantity': instance.quantity,
    };
