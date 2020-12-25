import 'package:flutter/material.dart';

class GetColors {
  static List<Color> fromHex(List<String> hexString) {
    final buffer = StringBuffer();
    List<Color> colors = [];
    for (var hex in hexString) {
      if (hex.length == 6 || hex.length == 7) buffer.write('ff');

      buffer.write(hex.replaceFirst('#', ''));
      colors.add(Color(int.parse(buffer.toString(), radix: 16)));
    }

    return colors;
  }
}
