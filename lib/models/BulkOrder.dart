import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/BulkOrderProduct.dart';
import 'package:living_desire/models/QuotationProducts.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/models/order_payment.dart';
import 'package:living_desire/models/quotation_tracking.dart';
import 'package:living_desire/models/sample_payment.dart';
import 'package:living_desire/models/sample_tracking.dart';
import 'package:living_desire/models/samples.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_item.dart';

class BulkOrder {

  final String key,authID,requestID,orderID,deliveryAddressID,assignedPersonID,orderInvoice,sampleOrderInvoice,sampleOrderID,sampleShipmentID,name,address,pincode,sampleInvoiceUrl,orderInvoiceUrl;

  final bool isSampleRequested;

  final int quotationStatus,orderPaymentUnpaid,orderPaymentPaid,samplePaymentUnpaid,samplePaymentPaid;

  final DateTime requestDate,placedDate,deliveryDate;

  var productType;

  final List<QuotationProducts> products;

  final List<Tracking> orderTracking;

  final List<QuotationTracking> quotationTracking;

  final List<Samples> samples ;

  final List<SampleTracking> sampleTracking;

  final List<SamplePayment> samplePayment;

  final List<OrderPayment> orderPayment;

  BulkOrder(
  {this.authID,
      this.key,
      this.name,
      this.address,
      this.requestID,
      this.orderID,
      this.pincode,
      this.placedDate,
      this.deliveryDate,
      this.products,
      this.deliveryAddressID,
      this.isSampleRequested,
      this.assignedPersonID,
      this.orderInvoice,
      this.sampleOrderInvoice,
      this.sampleOrderID,
      this.sampleShipmentID,
      this.productType,
      this.orderTracking,
      this.quotationTracking,
      this.quotationStatus,
      this.requestDate,
      this.samples,
      this.sampleTracking,
      this.orderPaymentPaid,
      this.orderPaymentUnpaid,
      this.samplePaymentPaid,
      this.samplePaymentUnpaid,
      this.orderInvoiceUrl,
      this.sampleInvoiceUrl,
      this.samplePayment,
      this.orderPayment});

  factory BulkOrder.fromJson(Map<String, dynamic> data) {

    if (data == null) return null;

    DateTime getDate(Map<String, dynamic> data){

      if(data == null)
        return null;

      return new Timestamp(data['_seconds'], data['_nanoseconds']).toDate();

    }

    List<QuotationProducts> getProductsList(List<dynamic> data){

      if(data == null)
        return null;

      List<QuotationProducts> temp = new List();

      for(int i=0;i<data.length;i++){

        QuotationProducts quotationProducts = QuotationProducts.fromJson(data[i]);
        temp.add(quotationProducts);

      }

      return temp;

    }

    List<QuotationTracking> getQuotationTrackingList(List<dynamic> data){

      if(data == null)
        return null;

      List<QuotationTracking> temp = new List();

      for(int i=0;i<data.length;i++){

        QuotationTracking quotationTracking = QuotationTracking.fromJson(data[i]);
        temp.add(quotationTracking);

      }

      return temp;

    }

    return BulkOrder(
        key: data['id'],
        requestDate: getDate(data['data']['requestDate']),
        placedDate: getDate(data['data']['placedDate']),
        deliveryDate: getDate(data['data']['deliveryDate']),
        products: getProductsList(data['data']['products'])  ,
        authID: data['data']['authID'],
        orderID: data['data']['orderID'],
        address: data['data']['address'],
        pincode: data['data']['pincode'],
        orderPaymentUnpaid: data['data']['orderPaymentUnpaid'],
        orderPaymentPaid: data['data']['orderPaymentPaid'],
        samplePaymentUnpaid: data['data']['samplePaymentUnpaid'],
        samplePaymentPaid: data['data']['samplePaymentPaid'],
        deliveryAddressID: data['data']['deliveryAddressID'],
        isSampleRequested: data['data']['isSampleRequested'],
        orderInvoiceUrl: data['data']['orderInvoiceUrl'],
        sampleInvoiceUrl: data['data']['sampleInvoiceUrl'],
        productType: data['data']['productType'],
        quotationStatus: data['data']['quotationStatus'],
        requestID: data['data']['requestID'],
        name: data['data']['name'],
        quotationTracking: getQuotationTrackingList(data['data']['quotationTracking']),

    );
  }



}