import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/get_colors.dart';

part 'localNormalCart.g.dart';

@HiveType(typeId: 2)
@JsonSerializable(nullable: false)
class NormalCartLocal {
  NormalCartLocal({
    this.key,
    this.dateAdded,
    this.productID,
    this.variantID,
    this.quantity,
  });

  @HiveField(0)
  @JsonKey(name: 'key')
  String key;
  @HiveField(1)
  @JsonKey(name: 'dateAdded')
  DateTime dateAdded;
  @HiveField(2)
  @JsonKey(name: 'variantID')
  String variantID;
  @HiveField(3)
  @JsonKey(name: 'productID')
  String productID;
  @HiveField(4)
  @JsonKey(name: 'quantity')
  int quantity;
}
