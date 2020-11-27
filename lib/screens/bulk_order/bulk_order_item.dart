import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';

class BulkOrderItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

      return MouseRegion(

        onEnter: (PointerEnterEvent event){},

        onExit: (PointerExitEvent event){},

        onHover: (PointerHoverEvent event){},

        child: Card(

          elevation: 2,
          color: Palette.secondaryColor,

          child: Image(
            image: AssetImage('assets/images/logo.jpeg'),
            width: 150,
          ),

        ),
      );

  }



}