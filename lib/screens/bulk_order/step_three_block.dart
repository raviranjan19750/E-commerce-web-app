import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_cart.dart';
import 'package:living_desire/screens/bulk_order/upload_logo.dart';
import 'package:provider/provider.dart';

class StepThreeBlock extends StatelessWidget{

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

            return Column(

              children: [

                Container(

                  width: double.infinity,

                  padding: EdgeInsets.all(16),

                  decoration: BoxDecoration(

                    color: Palette.secondaryColor,

                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        offset: Offset(0, 2),
                        blurRadius: 4.0,
                      )],

                  ),

                  margin: EdgeInsets.only(top: 32),

                  child: Text('Upload Design',style: TextStyle(color: Colors.white,fontSize: 24),),

                ),

                Container(

                    width: double.infinity,

                    height: 180,

                    padding: EdgeInsets.all(16),

                    decoration: BoxDecoration(

                      color: Colors.white,

                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 4.0,
                        )],

                    ),

                    child: ListView.builder(

                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return InkWell(

                              onTap: (){},

                              child: UploadLogo(index: index,size: 5,)
                          );
                        })

                ),

                Container(

                  padding: EdgeInsets.symmetric(vertical: 16),

                  child: TextField(

                    decoration: InputDecoration(

                        hintText: 'Comments (Optional)',

                        border: OutlineInputBorder(

                          borderRadius: BorderRadius.circular(8),

                        )

                    ),

                  ),
                )
              ],
            );
          },
        ));

  }



}