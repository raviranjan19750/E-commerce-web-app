import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(nullable: false)
class Product {
  // Model For Product
  @HiveField(0)
  @JsonKey(name: 'title')
  final String title;

  @HiveField(1)
  @JsonKey(name: 'imageUrls')
  final List<String> imageUrls;

  @HiveField(2)
  @JsonKey(name: 'discountPrice')
  final double discountPrice;

  @HiveField(3)
  @JsonKey(name: 'retailPrice')
  final double retailPrice;

  @HiveField(4)
  @JsonKey(name: 'size')
  final String size;

  @HiveField(5)
  @JsonKey(name: 'color')
  final List<String> color;

  @HiveField(6)
  @JsonKey(name: 'productId')
  final String productId;

  @HiveField(7)
  @JsonKey(name: 'varientId')
  final String varientId;

  final Set<String> tags;

  @HiveField(8)
  @JsonKey(name: 'type')
  final String type;

  @HiveField(9)
  @JsonKey(name: 'subType')
  final String subType;

  @HiveField(10)
  @JsonKey(name: 'isAvailable')
  final bool isAvailable;
  final bool isCombo;

  Product(
      {this.title,
      this.imageUrls,
      this.discountPrice,
      this.retailPrice,
      this.size,
      this.color,
      this.productId,
      this.varientId,
      this.tags,
      this.type,
      this.subType,
      this.isAvailable,
      this.isCombo});
}
