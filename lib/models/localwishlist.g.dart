// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localwishlist.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WishlistLocalAdapter extends TypeAdapter<WishlistLocal> {
  @override
  final int typeId = 4;

  @override
  WishlistLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WishlistLocal(
      key: fields[0] as String,
      productID: fields[2] as String,
      variantID: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WishlistLocal obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.key)
      ..writeByte(1)
      ..write(obj.variantID)
      ..writeByte(2)
      ..write(obj.productID);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WishlistLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WishlistLocal _$WishlistLocalFromJson(Map<String, dynamic> json) {
  return WishlistLocal(
    key: json['key'] as String,
    productID: json['productID'] as String,
    variantID: json['variantID'] as String,
  );
}

Map<String, dynamic> _$WishlistLocalToJson(WishlistLocal instance) =>
    <String, dynamic>{
      'key': instance.key,
      'variantID': instance.variantID,
      'productID': instance.productID,
    };
