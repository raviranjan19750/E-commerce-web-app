import 'package:living_desire/models/BulkOrderProduct.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/models/order_payment.dart';
import 'package:living_desire/models/quotation_tracking.dart';
import 'package:living_desire/models/sample_payment.dart';
import 'package:living_desire/models/sample_tracking.dart';
import 'package:living_desire/models/samples.dart';

class BulkOrder {

  final String authID,requestID,deliveryAddressID,assignedPersonID,orderInvoice,sampleOrderInvoice,sampleOrderID,sampleShipmentID;

  final List<BulkOrderProduct> products;

  final List<Tracking> orderTracking;

  final List<QuotationTracking> quotationTracking;

  final List<Samples> samples ;

  final List<SampleTracking> sampleTracking;

  final List<SamplePayment> samplePayment;

  final List<OrderPayment> orderPayment;

  BulkOrder(
  {this.authID,
      this.requestID,
      this.deliveryAddressID,
      this.assignedPersonID,
      this.orderInvoice,
      this.sampleOrderInvoice,
      this.sampleOrderID,
      this.sampleShipmentID,
      this.products,
      this.orderTracking,
      this.quotationTracking,
      this.samples,
      this.sampleTracking,
      this.samplePayment,
      this.orderPayment});
}