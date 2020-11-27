import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/configs.dart';
import 'package:provider/provider.dart';

class BulkOrderItem extends StatelessWidget{

  bool init = false;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => BulkOrderProvider(),
        child: Consumer<BulkOrderProvider>(
          builder: (BuildContext context, BulkOrderProvider value, Widget child) {
            if (!init) {
              Provider.of<BulkOrderProvider>(context, listen: false);
              init = true;
            }

            return MouseRegion(

              onEnter: (event) {
                value.onEnter();
              },
              onExit: (event) {
               value.onExit();
              },


              onHover: (PointerHoverEvent event){},

              child: InkWell(

                onTap: (){},

                child: Card(

                  elevation: value.elevation,
                  color: Palette.secondaryColor,

                  child: Image(
                    image: AssetImage('assets/images/logo.jpeg'),
                    width: 150 * value.size,
                    height: 200 * value.size,
                  ),

                ),
              ),
            );

          },
        ));
  }



  }


