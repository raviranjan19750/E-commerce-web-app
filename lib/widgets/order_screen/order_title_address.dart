import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:living_desire/data/data.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../models/models.dart';

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
  SuperTooltip tooltip;
  var contextTooltip;

  Future<bool> _willPopCallback() async {
    // If the tooltip is open we don't pop the page on a backbutton press
    // but close the ToolTip
    if (tooltip.isOpen) {
      tooltip.close();
      return false;
    }
    return true;
  }

  void onTap() {
    if (tooltip != null && tooltip.isOpen) {
      tooltip.close();
      return;
    }

    var renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

    var targetGlobalCenter = renderBox
        .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

    // We create the tooltip on the first use
    tooltip = SuperTooltip(
      content: Material(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.name),
            Text(widget.address),
            Text(widget.pincode),
            Text(widget.phone),
          ],
        ),
      ),
      popupDirection: TooltipDirection.down,
    );
    contextTooltip = context;
    tooltip.show(context);
  }

  @override
  Widget build(BuildContext context) {
    var tooltip;
    return MouseRegion(
      onEnter: (event) {
        var renderBox = context.findRenderObject() as RenderBox;
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;

        var targetGlobalCenter = renderBox.localToGlobal(
            renderBox.size.center(Offset.zero),
            ancestor: overlay);

        // We create the tooltip on the first use
        tooltip = SuperTooltip(
          content: Material(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name),
                Text(widget.address),
                Text(widget.pincode),
                Text(widget.phone),
              ],
            ),
          ),
          popupDirection: TooltipDirection.down,
        );
        contextTooltip = context;
        tooltip.show(context);
      },
      onExit: (event) {
        tooltip.close();
      },
      child: Text(widget.name),
    );

    // return WillPopScope(
    //   onWillPop: _willPopCallback,
    //   child: GestureDetector(
    //     onTap: onTap,
    //     child: Text(widget.name),
    //   ),
    // );
    // Tooltip(
    //   child: Text(widget.name),
    //   preferBelow: true,
    //   message: widget.name + '\n' + widget.address + '\n' + widget.phone,
    //   textStyle: TextStyle(
    //     color: Colors.black,
    //     fontSize: 12,
    //   ),
    //   padding: EdgeInsets.all(8.0),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     border: Border.all(
    //       color: Colors.orange[300],
    //     ),
    //   ),
    // );
  }
}
