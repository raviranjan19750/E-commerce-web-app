import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_quotation_provider.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/bulk_order/bulk_ooder_sample_payment.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_quotation_payment.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_quotation_products.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_samples.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/footer/FooterNew.dart';
import 'package:living_desire/widgets/footer/footer.dart';
import 'package:provider/provider.dart';


class BulkOrderQuotation extends StatelessWidget{

  String id;

  bool init = false;

  BulkOrderQuotation({this.id});


  Widget setPaymentColumn(BulkOrderQuotationProvider value){

    if(value.samplePaymentPaid){

      return  Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Visibility(visible:value.quotationPaymentUploaded,child: BulkOrderQuotationPayment(quotationPayment: value.quotationPayment,isPaid: value.quotationPaymentPaid,orderKey: id,orderInvoiceUrl: value.bulkOrder.orderInvoiceUrl,)),

          Visibility(

            visible: value.samplePaymentUploaded && value.quotationPaymentUploaded,

            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
              height: 1,
              color: Palette.secondaryColor,
            ),
          ),

          Visibility(visible:value.samplePaymentUploaded , child: BulkOrderSamplePayment(samplePayment: value.samplePayment,isPaid: value.samplePaymentPaid,orderKey: id,sampleInvoiceURL: value.bulkOrder.sampleInvoiceUrl,trackingList: value.bulkOrder.sampleTracking,)),



        ],

      );

    }
    else{

      return  Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Visibility(visible:value.samplePaymentUploaded , child: BulkOrderSamplePayment(samplePayment: value.samplePayment,isPaid: value.samplePaymentPaid,orderKey: id,sampleInvoiceURL: value.bulkOrder.sampleInvoiceUrl,trackingList: value.bulkOrder.sampleTracking,)),

          Visibility(

            visible: value.samplePaymentUploaded && value.quotationPaymentUploaded,

            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8,vertical: 16),
              height: 1,
              color: Palette.secondaryColor,
            ),
          ),

          Visibility(visible:value.quotationPaymentUploaded,child: BulkOrderQuotationPayment(quotationPayment: value.quotationPayment,isPaid: value.quotationPaymentPaid,orderKey: id,orderInvoiceUrl: value.bulkOrder.orderInvoiceUrl,)),


        ],

      );

    }

  }

  Widget setTables(BulkOrderQuotationProvider value){

    if(value.samplePaymentPaid){

      return Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          BulkOrderQuotationProducts(bulkOrder: value.bulkOrder,),

          Visibility(

              visible: (value.bulkOrder.samples.isNotEmpty),

              child: BulkOrderSamples(sampleList: value.bulkOrder.samples,)
          ),

          FooterNew(),

        ],

      );

    }
    else{

      return Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Visibility(

              visible: (value.bulkOrder.samples.isNotEmpty),
              child: BulkOrderSamples(sampleList: value.bulkOrder.samples,)
          ),

          BulkOrderQuotationProducts(bulkOrder: value.bulkOrder,),

          Footer(),

        ],

      );

    }

  }

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

                      child: setTables(value),

                    ),
                  ),

                  Visibility(

                    visible: value.samplePaymentUploaded || value.quotationPaymentUploaded,

                    replacement: Container(),

                    child: Container(

                      width: 480,

                      height: double.infinity,

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

                        child: setPaymentColumn(value),
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