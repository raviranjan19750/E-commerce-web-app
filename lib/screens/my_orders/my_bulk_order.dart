import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/my_bulk_order_provider.dart';
import 'package:living_desire/screens/my_orders/my_bulk_order_item.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/button_list.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';
import 'package:provider/provider.dart';

class MyBulkOrder extends StatelessWidget{


  bool init = false;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => MyBulkOrderProvider(),
        child: Consumer<MyBulkOrderProvider>(
          builder: (BuildContext context, MyBulkOrderProvider value, Widget child) {

            if (!init) {
              Provider.of<MyBulkOrderProvider>(context, listen: false).initBulkOrders();
              init = true;
            }

            return Scaffold(

              appBar: CustomAppBar(size: 92,visibleMiddleAppBar: false,visibleSubAppBar: true,),

              body: Row(

                children: [

                  ButtonList(isMyOrderSelected: true,),

                  Expanded(

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(


                          margin: EdgeInsets.only(left: 32,right: 64,top: 64),

                          width: double.infinity,

                          height: 1,

                          color: Colors.grey[500],

                        ),

                        Container(

                          margin: EdgeInsets.only(left: 16),

                          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                          child: LabelTag('${value.bulkOrdItems.length} Orders'),

                        ),

                        Expanded(

                          child: Visibility(

                            replacement: Center(child: CircularProgressIndicator(),),

                            child: ListView.builder(

                                itemCount: value.bulkOrdItems.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return Container(

                                    padding: EdgeInsets.symmetric(horizontal: 16),

                                    child: MyBulkOrderItem(bulkOrdItems: value.bulkOrdItems,index: index,),
                                  );
                                }),
                          ),
                        ),

                      ],

                    ),
                  ),
                ],
              ),
            );

          },
        ));



  }



}