import 'package:flutter/material.dart';

class ProductVariantColor {
  Color colorHexCode;
  String colorName;

  ProductVariantColor({
    this.colorHexCode,
    this.colorName,
  });

  factory ProductVariantColor.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    print('Data Model: ' + data.toString());

    Color fromHex(String hexString) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      //return Color(int.parse(buffer.toString(), radix: 16));
      return Color(int.parse(
        buffer.toString(),
        radix: 16,
      ));
    }

    return ProductVariantColor(
      colorHexCode: fromHex((data['hexCode'] as String)),
      colorName: data['name'],
    );
  }
}
