// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localCustomCart.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomCartLocalAdapter extends TypeAdapter<CustomCartLocal> {
  @override
  final int typeId = 3;

  @override
  CustomCartLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomCartLocal(
      productId: fields[0] as String,
      variantId: fields[1] as String,
      quantity: fields[2] as int,
      productType: fields[3] as String,
      productSubType: fields[4] as String,
      size: fields[5] as String,
      colour: (fields[6] as List)?.cast<dynamic>(),
      description: fields[7] as String,
      images: (fields[9] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, CustomCartLocal obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.variantId)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.productType)
      ..writeByte(4)
      ..write(obj.productSubType)
      ..writeByte(5)
      ..write(obj.size)
      ..writeByte(6)
      ..write(obj.colour)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomCartLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomCartLocal _$CustomCartLocalFromJson(Map<String, dynamic> json) {
  return CustomCartLocal(
    productId: json['productID'] as String,
    variantId: json['varientID'] as String,
    quantity: json['quantity'] as int,
    productType: json['productType'] as String,
    productSubType: json['productSubType'] as String,
    size: json['size'] as String,
    colour: json['colour'] as List,
    description: json['description'] as String,
    images: json['images'] as List,
  );
}

Map<String, dynamic> _$CustomCartLocalToJson(CustomCartLocal instance) =>
    <String, dynamic>{
      'productID': instance.productId,
      'varientID': instance.variantId,
      'quantity': instance.quantity,
      'productType': instance.productType,
      'productSubType': instance.productSubType,
      'size': instance.size,
      'colour': instance.colour,
      'description': instance.description,
      'images': instance.images,
    };
