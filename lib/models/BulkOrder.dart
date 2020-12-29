import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/BulkOrderProduct.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/models/order_payment.dart';
import 'package:living_desire/models/quotation_tracking.dart';
import 'package:living_desire/models/sample_payment.dart';
import 'package:living_desire/models/sample_tracking.dart';
import 'package:living_desire/models/samples.dart';

class BulkOrder {

  final String key,authID,requestID,deliveryAddressID,assignedPersonID,orderInvoice,sampleOrderInvoice,sampleOrderID,sampleShipmentID;

  final bool isSampleRequested;

  final int quotationStatus;

  final DateTime requestDate;

  var productType;


  final List<Tracking> orderTracking;

  final List<QuotationTracking> quotationTracking;

  final List<Samples> samples ;

  final List<SampleTracking> sampleTracking;

  final List<SamplePayment> samplePayment;

  final List<OrderPayment> orderPayment;

  BulkOrder(
  {this.authID,
      this.key,
      this.requestID,
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
      this.samplePayment,
      this.orderPayment});

  factory BulkOrder.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;

    print(data['data']);


    return BulkOrder(
        key: data['id'],
        requestDate: new Timestamp(
            data['data']['requestDate']["_seconds"],
            data['data']['requestDate']["_nanoseconds"])
            .toDate(),
        authID: data['data']['authID'],
        deliveryAddressID: data['data']['deliveryAddressID'],
        isSampleRequested: data['data']['isSampleRequested'],
        productType: data['data']['productType'],
        quotationStatus: data['data']['quotationStatus'],
        requestID: data['data']['requestID'],
        //quotationTracking: data['data']['quotationTracking'],

    );
  }
}