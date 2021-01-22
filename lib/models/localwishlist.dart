import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'localwishlist.g.dart';

@HiveType(typeId: 4)
@JsonSerializable(nullable: false)
class WishlistLocal {
  WishlistLocal({
    this.key,
    this.productID,
    this.variantID,
  });

  @HiveField(0)
  @JsonKey(name: 'key')
  String key;
  @HiveField(1)
  @JsonKey(name: 'variantID')
  String variantID;
  @HiveField(2)
  @JsonKey(name: 'productID')
  String productID;
}
