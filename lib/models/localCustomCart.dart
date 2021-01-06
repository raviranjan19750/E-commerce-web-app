import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'localCustomCart.g.dart';

@HiveType(typeId: 3)
@JsonSerializable(nullable: false)
class CustomCartLocal {
  CustomCartLocal({
    this.productId,
    this.variantId,
    this.quantity,
    this.productType,
    this.productSubType,
    this.size,
    this.colour,
    this.description,
    this.images,
  });

  @HiveField(0)
  @JsonKey(name: 'productId')
  String productId;
  @HiveField(1)
  @JsonKey(name: 'varientId')
  String variantId;
  @HiveField(2)
  @JsonKey(name: 'quantity')
  int quantity;
  @HiveField(3)
  @JsonKey(name: 'productType')
  String productType;
  @HiveField(4)
  @JsonKey(name: 'productSubType')
  String productSubType;
  @HiveField(5)
  @JsonKey(name: 'size')
  String size;
  @HiveField(6)
  @JsonKey(name: 'colour')
  var colour = new List.empty();
  @HiveField(7)
  @JsonKey(name: 'description')
  String description;
  @HiveField(9)
  @JsonKey(name: 'images')
  var images = new List.empty();
}
