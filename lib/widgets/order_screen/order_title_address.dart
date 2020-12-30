import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart' show SystemChannels;
import 'package:super_tooltip/super_tooltip.dart';

import 'dart:async';
import '../widgets.dart';

class OrderTitleAddress extends StatefulWidget {
  final String name;
  final String address;
  final String pincode;
  final String phone;

  const OrderTitleAddress({
    Key key,
    this.address,
    this.name,
    this.phone,
    this.pincode,
  }) : super(key: key);

  @override
  _OrderTitleAddressState createState() => _OrderTitleAddressState();
}

class _OrderTitleAddressState extends State<OrderTitleAddress> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message:
          ('${widget.name}\n${widget.address}\n${widget.pincode}\n\n\n${widget.phone}'),
      child: Text(widget.name),
      textStyle: TextStyle(
        //fontFeatures: [FontFeature(feature)],

        color: Colors.black,
        fontSize: 14,
      ),
      padding: const EdgeInsets.all(8),
      excludeFromSemantics: true,
      decoration: BoxDecoration(
        boxShadow: [
          //background color of box
          BoxShadow(
            color: Colors.grey,

            blurRadius: 25.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              0, // Move to right 10  horizontally
              0, // Move to bottom 10 Vertically
            ),
          )
        ],
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        border: Border.all(
          color: Colors.orange,
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return CustomTooltip(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: Colors.black,
//         ),
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(5),
//       ),
//       height: MediaQuery.of(context).size.height * 0.14,
//       width: MediaQuery.of(context).size.width * 0.2,
//       message: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             widget.name,
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 14,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(
//               vertical: 8.0,
//             ),
//             child: Text(
//               widget.address,
//               maxLines: 4,
//               style: TextStyle(
//                 decoration: TextDecoration.none,
//                 color: Colors.black,
//                 fontSize: 14,
//               ),
//             ),
//           ),
//           Text(
//             widget.phone,
//             style: TextStyle(
//               decoration: TextDecoration.none,
//               color: Colors.black,
//               fontSize: 14,
//             ),
//           )
//         ],
//       ),
//       child: Text(widget.name),
//     );
//   }
// }
