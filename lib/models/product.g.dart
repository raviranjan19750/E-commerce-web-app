// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 1;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      title: fields[0] as String,
      imageUrls: (fields[1] as List)?.cast<String>(),
      discountPrice: fields[2] as double,
      retailPrice: fields[3] as double,
      size: fields[4] as String,
      color: (fields[5] as List)?.cast<String>(),
      productId: fields[6] as String,
      varientId: fields[7] as String,
      type: fields[8] as String,
      subType: fields[9] as String,
      isAvailable: fields[10] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.imageUrls)
      ..writeByte(2)
      ..write(obj.discountPrice)
      ..writeByte(3)
      ..write(obj.retailPrice)
      ..writeByte(4)
      ..write(obj.size)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.productId)
      ..writeByte(7)
      ..write(obj.varientId)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.subType)
      ..writeByte(10)
      ..write(obj.isAvailable);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
    title: json['title'] as String,
    imageUrls: (json['imageUrls'] as List).map((e) => e as String).toList(),
    discountPrice: (json['discountPrice'] as num).toDouble(),
    retailPrice: (json['retailPrice'] as num).toDouble(),
    size: json['size'] as String,
    color: (json['color'] as List).map((e) => e as String).toList(),
    productId: json['productId'] as String,
    varientId: json['varientId'] as String,
    tags: (json['tags'] as List).map((e) => e as String).toSet(),
    type: json['type'] as String,
    subType: json['subType'] as String,
    isAvailable: json['isAvailable'] as bool,
    isCombo: json['isCombo'] as bool,
  );
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'title': instance.title,
      'imageUrls': instance.imageUrls,
      'discountPrice': instance.discountPrice,
      'retailPrice': instance.retailPrice,
      'size': instance.size,
      'color': instance.color,
      'productId': instance.productId,
      'varientId': instance.varientId,
      'tags': instance.tags.toList(),
      'type': instance.type,
      'subType': instance.subType,
      'isAvailable': instance.isAvailable,
      'isCombo': instance.isCombo,
    };
