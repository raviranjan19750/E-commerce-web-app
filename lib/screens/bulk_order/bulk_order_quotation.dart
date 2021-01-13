import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:living_desire/ProviderModels/bulk_order_quotation_provider.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/BulkOrder.dart';
import 'package:living_desire/models/StringToHexColor.dart';
import 'package:living_desire/screens/bulk_order/bulk_ooder_sample_payment.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_quotation_payment.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_quotation_products.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_samples.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/footer/footer.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';
import 'package:provider/provider.dart';


class BulkOrderQuotation extends StatelessWidget{

  String id;

  bool init = false;

  BulkOrderQuotation({this.id});


  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => BulkOrderQuotationProvider(),
        child: Consumer<BulkOrderQuotationProvider>(
          builder: (BuildContext context, BulkOrderQuotationProvider value, Widget child) {

            if (!init) {
              Provider.of<BulkOrderQuotationProvider>(context, listen: false).initQuotation(id);
              init = true;
            }

            return Scaffold(

              appBar: CustomAppBar(visibleSubAppBar: false,visibleMiddleAppBar: true,),

              body: (value.isInitialized) ?Row(
                children: [

                  Expanded(

                    child: SingleChildScrollView(

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Visibility(

                              visible: (value.bulkOrder.samples.isNotEmpty),
                              child: BulkOrderSamples(sampleList: value.bulkOrder.samples,)
                          ),

                          BulkOrderQuotationProducts(bulkOrder: value.bulkOrder,),

                          Footer(),

                        ],

                      ),

                    ),
                  ),
                  Container(

                    width: 480,

                    decoration: BoxDecoration(

                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, -2),
                            blurRadius: 4.0,
                          )],

                        color: Colors.white

                    ),

                    child: SingleChildScrollView(

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          BulkOrderSamplePayment(samplePayment: value.samplePayment,),

                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                            height: 1,
                            color: Palette.secondaryColor,
                          ),

                          BulkOrderQuotationPayment(quotationPayment: value.quotationPayment,),

                        ],

                      ),
                    ),

                  ),
                ],
              ) : Center(child: CircularProgressIndicator(),),

            );

          },
        ));




  }




}