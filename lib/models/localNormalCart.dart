import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'localNormalCart.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(nullable: false)
class NormalCartLocal {
  NormalCartLocal({
    this.productId,
    this.variantId,
    this.quantity,
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
}
