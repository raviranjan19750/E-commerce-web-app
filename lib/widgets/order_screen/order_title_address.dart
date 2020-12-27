import 'dart:ui';
import 'package:flutter/material.dart';

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
  // var contextTooltip;

  // Future<bool> _willPopCallback() async {
  //   // If the tooltip is open we don't pop the page on a backbutton press
  //   // but close the ToolTip
  //   if (tooltip.isOpen) {
  //     tooltip.close();
  //     return false;
  //   }
  //   return true;
  // }

  // void onTap() {
  //   if (tooltip != null && tooltip.isOpen) {
  //     tooltip.close();
  //     return;
  //   }

  //   var renderBox = context.findRenderObject() as RenderBox;
  //   final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  //   var targetGlobalCenter = renderBox
  //       .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

  //   // We create the tooltip on the first use
  //   tooltip = SuperTooltip(
  //     popupDirection: TooltipDirection.left,
  //     arrowTipDistance: 15.0,
  //     arrowBaseWidth: 40.0,
  //     arrowLength: 40.0,
  //     borderColor: Colors.green,
  //     borderWidth: 5.0,
  //     snapsFarAwayVertically: true,
  //     showCloseButton: ShowCloseButton.inside,
  //     hasShadow: false,
  //     touchThrougArea: new Rect.fromLTWH(targetGlobalCenter.dx - 100,
  //         targetGlobalCenter.dy - 100, 200.0, 160.0),
  //     touchThroughAreaShape: ClipAreaShape.rectangle,
  //     content: new Material(
  //         child: Padding(
  //       padding: const EdgeInsets.only(top: 20.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(widget.name),
  //           Text(widget.address),
  //           Text(widget.pincode),
  //           Text(widget.phone),
  //         ],
  //       ),
  //     )),
  //   );

  //   tooltip.show(context);
  // }

  // void onTap() {
  //   if (tooltip != null && tooltip.isOpen) {
  //     tooltip.close();
  //     return;
  //   }

  //   var renderBox = context.findRenderObject() as RenderBox;
  //   final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;

  //   var targetGlobalCenter = renderBox
  //       .localToGlobal(renderBox.size.center(Offset.zero), ancestor: overlay);

  //   // We create the tooltip on the first use
  //   tooltip = SuperTooltip(
  //     content: Material(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(widget.name),
  //           Text(widget.address),
  //           Text(widget.pincode),
  //           Text(widget.phone),
  //         ],
  //       ),
  //     ),
  //     popupDirection: TooltipDirection.down,
  //   );
  //   contextTooltip = context;
  //   tooltip.show(context);
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Text(widget.name),
        Positioned(
          bottom: 130,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: ShapeDecoration(
              color: Colors.red,
              shape: TooltipShapeBorder(arrowArc: 0.5),
              shadows: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(2, 2))
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text('Text 22', style: TextStyle(color: Colors.white)),
            ),
          ),
        ),
      ],
    );
    // Positioned.fill(
    //   child: IgnorePointer(
    //     child: CustomSingleChildLayout(
    //       delegate: TooltipPositionDelegate(
    //         target: target,
    //         verticalOffset: verticalOffset,
    //         preferBelow: preferBelow,
    //       ),
    //       child: FadeTransition(
    //         opacity: animation,
    //         child: Opacity(
    //           opacity: 0.9,
    //           child: ConstrainedBox(
    //             constraints: BoxConstraints(minHeight: height),
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 color: darkTheme.backgroundColor,
    //                 borderRadius: BorderRadius.circular(2.0),
    //               ),
    //               padding: padding,
    //               child: Center(
    //                 widthFactor: 1.0,
    //                 heightFactor: 1.0,
    //                 child: Text(message, style: darkTheme.textTheme.body1),
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
    //Tooltip(
    //   preferBelow: true,
    //   verticalOffset: 20,
    //   padding: EdgeInsets.all(8),
    //   margin: EdgeInsets.all(12),
    //   textStyle: TextStyle(
    //     color: Colors.black,
    //     fontSize: 14,
    //   ),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     // backgroundBlendMode: Blen
    //   ),
    //   message:
    //       '${widget.name}\n${widget.address}\n${widget.pincode}\n\n${widget.phone}',
    //   child: Text(widget.name),
    // );
  }
}

class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;

  TooltipShapeBorder({
    this.radius = 16.0,
    this.arrowWidth = 20.0,
    this.arrowHeight = 10.0,
    this.arrowArc = 0.0,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    double x = arrowWidth, y = arrowHeight, r = 1 - arrowArc;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.bottomCenter.dx + x / 2, rect.bottomCenter.dy)
      ..relativeLineTo(x / 2 * r, y * r)
      ..relativeQuadraticBezierTo(x / 2 * (1 - r), y * (1 - r), x * (1 - r), 0)
      ..relativeLineTo(x / 2 * r, -y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
