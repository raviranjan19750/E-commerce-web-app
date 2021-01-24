import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/check_promo_code/check_promo_code_bloc.dart';
import 'package:living_desire/bloc/select_address/select_address_bloc.dart';
import 'package:living_desire/bloc/select_address_type/select_address_type_bloc.dart';
import 'package:living_desire/bloc/select_payment/select_payment_bloc.dart';
import 'package:living_desire/models/PaymentMethod.dart';

import 'package:living_desire/models/buy_now_details.dart';
import 'package:living_desire/models/models.dart';
import '../../config/configs.dart';
import '../widgets.dart';

class SelectAddressCartTotal extends StatelessWidget {
  final String authID;
  final String productID;
  final String variantID;
  final String totalItems;
  final String isSampleRequestedStr;
  final String isBulkOrderCartStr;
  final SelectAddressStateType type;
  String deliveryAddressID;

  SelectAddressCartTotal({
    Key key,
    this.authID,
    this.productID,
    this.variantID,
    this.totalItems,
    this.isSampleRequestedStr,
    this.isBulkOrderCartStr,
    this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(type.toString());
    bool isSampleRequested;
    if (isSampleRequestedStr == "true") {
      isSampleRequested = true;
    } else {
      isSampleRequested = false;
    }
    bool isBulkOrderCart;
    if (isBulkOrderCartStr == "true") {
      isBulkOrderCart = true;
    } else {
      isBulkOrderCart = false;
    }
    String promoCode = '';
    // return TotalView();
    return BlocBuilder<SelectAddressBloc, SelectAddressState>(
        builder: (context, state) {
      if (state is SelectAddressDetailLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SelectAddressDetailLoadingSuccessful) {
        if (state.address == null) {
          return Card(
            elevation: 5,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.error),
                    Text('Select An Address to continue'),
                  ],
                ),
              ),
            ),
          );
        } else {
          deliveryAddressID = state.address.key;
          return MultiBlocProvider(
            providers: [
              if (type == SelectAddressStateType.BUY_NOW)
                BlocProvider(
                    create: (context) => SelectAddressTypeBloc(
                        selectAddressTypeRepository:
                            RepositoryProvider.of(context))
                      ..add(LoadBuyNowDetails(
                        authID: authID,
                        deliveryAddressID: state.address.key,
                        productID: productID,
                        variantID: variantID,
                      ))),
              if (type == SelectAddressStateType.NORMAL_CART)
                BlocProvider(
                    create: (context) => SelectAddressTypeBloc(
                        selectAddressTypeRepository:
                            RepositoryProvider.of(context))
                      ..add(LoadNormalCartDetails(
                        authID: authID,
                        deliveryAddressID: state.address.key,
                      ))),
              if (type == SelectAddressStateType.BULK_ORDER)
                BlocProvider(
                    create: (context) => SelectAddressTypeBloc(
                        selectAddressTypeRepository:
                            RepositoryProvider.of(context))
                      ..add(LoadBulkOrderCartDetails(
                        authID: authID,
                        deliveryAddressID: state.address.key,
                        totalItems: totalItems,
                        isBulkOrderCart: isBulkOrderCart,
                        isSampleRequested: isSampleRequested,
                      ))),
            ],
            child: BlocBuilder<SelectAddressTypeBloc, SelectAddressTypeState>(
              builder: (context, state) {
                if (state is BuyNowDetailLoadingSucessfull) {
                  return TotalView(
                    authID: authID,
                    deliveryCharges: state.buyNowDetails.deliveryCharges,
                    discount: state.buyNowDetails.discount,
                    payingAmount: state.buyNowDetails.payingAmount,
                    totalAmount: state.buyNowDetails.totalAmount,
                    totalItems: state.buyNowDetails.totalItems,
                    totalPayingAmount: state.buyNowDetails.totalPayingAmount,
                    razorpayOrderID:
                        state.buyNowDetails.paymentData.razorpayOrderID,
                    orderID: state.buyNowDetails.paymentData.orderID,
                    taxAmount: state.buyNowDetails.taxAmount,
                    walletAmount: state.buyNowDetails.walletAmount,
                    deliveryAddressID: deliveryAddressID,
                    cartKeys: state.buyNowDetails.cartKeys,
                  );
                } else if (state is NormalCartDetailLoadingSuccessfull) {
                  return TotalView(
                    authID: authID,
                    deliveryCharges: state.normalCartDetails.deliveryCharges,
                    discount: state.normalCartDetails.discount,
                    payingAmount: state.normalCartDetails.payingAmount,
                    totalPayingAmount:
                        state.normalCartDetails.totalPayingAmount,
                    totalAmount: state.normalCartDetails.totalAmount,
                    totalItems: state.normalCartDetails.totalItems,
                    razorpayOrderID:
                        state.normalCartDetails.paymentData.razorpayOrderID,
                    orderID: state.normalCartDetails.paymentData.orderID,
                    taxAmount: state.normalCartDetails.taxAmount,
                    walletAmount: state.normalCartDetails.walletAmount,
                    deliveryAddressID: deliveryAddressID,
                    cartKeys: state.normalCartDetails.cartKeys,
                  );
                } else if (state is BulkOrderDetailLoadingSuccessfull) {
                  return TotalView(
                    authID: authID,
                    totalBulkItems: state.totalItems,
                    isBulkOrderCart: state.isBulkOrderCart,
                    deliveryAddressID: state.deliveryAddressID,
                    isSampleRequested: state.isSampleRequested,
                  );
                }
                return Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Card(
                    elevation: 5,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              },
            ),
          );
        }
      }
      return Container(
        width: MediaQuery.of(context).size.width * 0.25,
        height: MediaQuery.of(context).size.height * 0.5,
        child: Card(
          elevation: 5,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    });
  }
}

class TotalView extends StatelessWidget {
  final int totalItems;
  final double totalAmount;
  final double payingAmount;
  final bool isSampleRequested;
  final double discount;
  final String deliveryAddressID;
  final bool isBulkOrderCart;
  final double deliveryCharges;
  final String authID;
  final String razorpayOrderID;
  final double totalPayingAmount;
  final String orderID;
  final double walletAmount;
  final String totalBulkItems;
  final double taxAmount;
  final List<String> cartKeys;

  const TotalView({
    Key key,
    this.totalItems,
    this.authID,
    this.totalAmount,
    this.isSampleRequested,
    this.totalBulkItems,
    this.payingAmount,
    this.discount,
    this.deliveryAddressID,
    this.deliveryCharges,
    this.orderID,
    this.razorpayOrderID,
    this.taxAmount,
    this.walletAmount,
    this.isBulkOrderCart,
    this.cartKeys,
    this.totalPayingAmount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int paymentMode = 0;
    String promoCode;
    TextEditingController textEditingController;

    textEditingController = TextEditingController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SelectPaymentBloc()),
        BlocProvider(
          create: (context) => CheckPromoCodeBloc(
              promoCodeRepository: RepositoryProvider.of(context)),
        ),
      ],
      child: Card(
        elevation: 5.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sub Total
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 8.0,
                ),
                child: isBulkOrderCart == true
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Strings.totalItems,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              totalItems.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Strings.subTotal + ' (${totalItems} Item):',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '\u{20B9} ' + totalAmount.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              // Discount
              isBulkOrderCart == true
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 8.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Strings.discount,
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '\u{20B9} ' + discount.toString(),
                              style: TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              // Divider
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.25,
                  color: Colors.black,
                ),
              ),

              // Paying Amount: Total
              isBulkOrderCart == true
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Strings.total,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\u{20B9} ' + payingAmount.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              // Coupon Discount
              isBulkOrderCart == true
                  ? SizedBox.shrink()
                  : BlocBuilder<CheckPromoCodeBloc, PromoCodeAvailabilityState>(
                      builder: (context, state) {
                      if (state is PromoCodeDetailAvailabilityChecking)
                        return Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircularProgressIndicator(),
                        );
                      else if (state
                          is PromoCodeDetailAvailabilityCheckingSuccessful)
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (state.checkPromoCodeAvailability.couponType ==
                                102)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 8.0,
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        Strings.couponDiscount,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '\u{20B9} ' +
                                            state.checkPromoCodeAvailability
                                                .discount
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else if (state
                                    .checkPromoCodeAvailability.couponType ==
                                103)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 8.0,
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        Strings.cashbackAmount,
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '\u{20B9} ' +
                                            state.checkPromoCodeAvailability
                                                .discount
                                                .toString(),
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 8.0,
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        Strings.couponDiscount,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        '\u{20B9} ' + '0',
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        );
                      else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 8.0,
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Strings.couponDiscount,
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  '\u{20B9} ' + '0',
                                  style: TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    }),

              // TAX Amount
              isBulkOrderCart == true
                  ? SizedBox.shrink()
                  : BlocBuilder<CheckPromoCodeBloc, PromoCodeAvailabilityState>(
                      builder: (context, state) {
                      if (state is PromoCodeDetailAvailabilityChecking) {
                        return CircularProgressIndicator();
                      } else if (state
                          is PromoCodeDetailAvailabilityCheckingSuccessful) {
                        if (state.checkPromoCodeAvailability.couponType ==
                            102) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    Strings.tax,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    '\u{20B9} ' +
                                        state.checkPromoCodeAvailability
                                            .taxAmount
                                            .toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 8.0,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.25,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '\u{20B9} ' + Strings.tax,
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    taxAmount.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8.0,
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                Strings.tax,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '\u{20B9} ' + taxAmount.toString(),
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

              // Delivery Charges
              isBulkOrderCart == true
                  ? SizedBox.fromSize()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Strings.deliveryCharges,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '\u{20B9} ' + deliveryCharges.toString(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              // Wallet Amount
              isBulkOrderCart == true
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Strings.wallet,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '\u{20B9} ' + walletAmount.toString(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

              SizedBox(
                height: 20,
              ),

              // Get Quotation Button
              isBulkOrderCart == true
                  ? GetQuotationButton(
                      authID: authID,
                      deliveryAddressID: deliveryAddressID,
                      isSampleRequested: isSampleRequested,
                    )
                  : SizedBox.shrink(),

              // Select Payment Method
              isBulkOrderCart == true
                  ? SizedBox.shrink()
                  : BlocBuilder<SelectPaymentBloc, SelectPaymentState>(
                      builder: (context, state) {
                      if (state is LoadSelectPayment) {
                        String assetUrl = '';
                        String pay = '';
                        if (state.paymentMode == 101) {
                          assetUrl = 'assets/images/debit_card.png';
                          pay = 'Pay Using Debit Card';
                        } else if (state.paymentMode == 102) {
                          assetUrl = 'assets/images/credit_card.png';
                          pay = 'Pay Using Credit Card';
                        } else if (state.paymentMode == 103) {
                          assetUrl = 'assets/images/netbanking.png';
                          pay = 'Pay Using Netbanking';
                        } else if (state.paymentMode == 104) {
                          assetUrl = 'assets/images/google_pay.png';
                          pay = 'Pay Using GPAY';
                        } else if (state.paymentMode == 105) {
                          assetUrl = 'assets/images/upi.png';
                          pay = 'Pay Using BHIM UPI';
                        } else if (state.paymentMode == 106) {
                          assetUrl = 'assets/images/paytm.png';
                          pay = 'Pay Using Paytm UPI';
                        } else if (state.paymentMode == 107) {
                          assetUrl = 'assets/images/pone_pe.png';
                          pay = 'Pay Using Phonepe UPI';
                        } else if (state.paymentMode == 108) {
                          assetUrl = 'assets/images/whatsapp.png';
                          pay = 'Pay Using Whatsapp UPI';
                        } else if (state.paymentMode == 109) {
                          assetUrl = 'assets/images/amazon.png';
                          pay = 'Pay Using Amazon pay UPI';
                        }
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                BlocProvider.of<SelectPaymentBloc>(context)
                                    .add(LoadSelectPaymentDialog());
                                BlocProvider.of<CheckPromoCodeBloc>(context)
                                    .add(RemovePromoCode());
                              },
                              child: Card(
                                elevation: 5,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Image.asset(
                                            assetUrl,
                                            height: 48,
                                            width: 48,
                                          ),
                                        ),
                                        Text(
                                          pay,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SelectPaymentMethod();
                      }
                    }),

              BlocConsumer<SelectPaymentBloc, SelectPaymentState>(
                listener: (context, state) {
                  if (state is LaunchSelectPaymentDialog) {
                    return showDialog(
                      context: context,
                      builder: (BuildContext buildContext) {
                        return SelectPaymentDialog(
                          onAction: (val) =>
                              BlocProvider.of<SelectPaymentBloc>(context)
                                  .add(val),
                        );
                      },
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadSelectPayment) {
                    return GetPromoCode(
                      authID: authID,
                      payingAmount: payingAmount,
                      paymentMode: state.paymentMode,
                      orderID: orderID,
                      totalPayingAmount: totalPayingAmount,
                      walletAmount: walletAmount,
                      taxAmount: taxAmount,
                      razorpayOrderID: razorpayOrderID,
                      deliveryAddressID: deliveryAddressID,
                      deliveryCharges: deliveryCharges,
                      cartKeys: cartKeys,
                    );
                  }
                  return Container();
                },
              ),

              SizedBox(
                height: 20,
              ),

              // Need Help
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Text(
                        Strings.needHelp,
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectPaymentMethod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          BlocProvider.of<SelectPaymentBloc>(context)
              .add(LoadSelectPaymentDialog());
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Palette.secondaryColor,
          ),
          child: Center(
            child: Text(
              Strings.selectPaymentMethod,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Select Payment Method Dialog Box
class SelectPaymentDialog extends StatefulWidget {
  final Function onAction;
  int selectedIndex;
  int selectedPaymentMethod = 0;

  List<PaymentMethodOptions> paymentMethods = new List();
  SelectPaymentDialog({Key key, this.onAction}) : super(key: key);
  @override
  _SelectPaymentDialogState createState() => _SelectPaymentDialogState();
}

class _SelectPaymentDialogState extends State<SelectPaymentDialog> {
  Mode debit = new Mode(
      description: 'Visa, MasterCard, ...etc.',
      code: 101,
      asset: 'assets/images/debit_card.png');
  Mode credit = new Mode(
      description: 'Visa, MasterCard, ...etc.',
      code: 102,
      asset: 'assets/images/credit_card.png');
  Mode netBanking = new Mode(
      description: 'HDFC ,SBI , Axis ..etc. ',
      code: 103,
      asset: 'assets/images/netbanking.png');
  Mode googlePayUPI = new Mode(
      description: 'Google Pay',
      code: 104,
      asset: 'assets/images/google_pay.png');
  Mode bhimUPI =
      new Mode(description: 'BHIM', code: 105, asset: 'assets/images/upi.png');
  Mode payTmUPI = new Mode(
      description: 'PayTM', code: 106, asset: 'assets/images/paytm.png');
  Mode phonePeUPI = new Mode(
      description: 'Phone Pe', code: 107, asset: 'assets/images/pone_pe.png');
  Mode whatsAppUPI = new Mode(
      description: 'WhatsApp', code: 108, asset: 'assets/images/whatsapp.png');
  Mode amazonUPI = new Mode(
      description: 'Amazon', code: 109, asset: 'assets/images/amazon.png');

  @override
  Widget build(BuildContext context) {
    widget.paymentMethods.clear();
    widget.paymentMethods
        .add(new PaymentMethodOptions(method: 'Debit Card', modes: [debit]));

    widget.paymentMethods
        .add(new PaymentMethodOptions(method: 'Credit Card', modes: [credit]));
    widget.paymentMethods.add(
        new PaymentMethodOptions(method: 'Net Banking', modes: [netBanking]));
    widget.paymentMethods.add(new PaymentMethodOptions(method: 'UPI', modes: [
      googlePayUPI,
      bhimUPI,
      payTmUPI,
      phonePeUPI,
      whatsAppUPI,
      amazonUPI
    ]));

    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.65,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Select Payment Method
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Strings.selectPaymentMethod,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: widget.paymentMethods.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (widget.paymentMethods
                                  .elementAt(index)
                                  .modes
                                  .length ==
                              1) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: (widget.selectedPaymentMethod ==
                                        widget.paymentMethods
                                            .elementAt(index)
                                            .modes
                                            .first
                                            .code)
                                    ? Palette.secondaryColor
                                    : Colors.grey[200],
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 2),
                                    blurRadius: 3,
                                  )
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  /// SetState
                                  setState(() {
                                    widget.selectedPaymentMethod = widget
                                        .paymentMethods
                                        .elementAt(index)
                                        .modes
                                        .first
                                        .code;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        widget.paymentMethods
                                            .elementAt(index)
                                            .modes
                                            .first
                                            .asset,
                                        height: 48,
                                        width: 48,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, top: 8, bottom: 4),
                                              child: Text(
                                                widget.paymentMethods
                                                    .elementAt(index)
                                                    .method,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: (widget
                                                                .selectedPaymentMethod ==
                                                            widget
                                                                .paymentMethods
                                                                .elementAt(
                                                                    index)
                                                                .modes
                                                                .first
                                                                .code)
                                                        ? Colors.white
                                                        : Palette
                                                            .secondaryColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 16, bottom: 8),
                                              child: Text(
                                                widget.paymentMethods
                                                    .elementAt(index)
                                                    .modes
                                                    .first
                                                    .description,
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: (widget
                                                              .selectedPaymentMethod ==
                                                          widget.paymentMethods
                                                              .elementAt(index)
                                                              .modes
                                                              .first
                                                              .code)
                                                      ? Colors.white
                                                      : Palette.secondaryColor,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0, 2),
                                    blurRadius: 3,
                                  )
                                ],
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 16, top: 8, bottom: 4),
                                        child: Text(
                                          widget.paymentMethods
                                              .elementAt(index)
                                              .method,
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Palette.secondaryColor,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: widget.paymentMethods
                                          .elementAt(index)
                                          .modes
                                          .length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio:
                                            (MediaQuery.of(context)
                                                    .size
                                                    .width) /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2),
                                      ),
                                      itemBuilder: (BuildContext context,
                                          int insideIndex) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              widget.selectedPaymentMethod =
                                                  widget.paymentMethods
                                                      .elementAt(index)
                                                      .modes
                                                      .elementAt(insideIndex)
                                                      .code;
                                            });
                                          },
                                          child: new Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.all(8),
                                            padding: EdgeInsets.only(
                                                left: 16, top: 8, bottom: 8),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        Palette.secondaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color:
                                                    (widget.selectedPaymentMethod ==
                                                            widget
                                                                .paymentMethods
                                                                .elementAt(
                                                                    index)
                                                                .modes
                                                                .elementAt(
                                                                    insideIndex)
                                                                .code)
                                                        ? Palette.secondaryColor
                                                        : Colors.white),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  widget.paymentMethods
                                                      .elementAt(index)
                                                      .modes
                                                      .elementAt(insideIndex)
                                                      .asset,
                                                  width: 48,
                                                  height: 48,
                                                ),
                                                Text(
                                                  '    ' +
                                                      widget.paymentMethods
                                                          .elementAt(index)
                                                          .modes
                                                          .elementAt(
                                                              insideIndex)
                                                          .description,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: (widget
                                                                  .selectedPaymentMethod ==
                                                              widget
                                                                  .paymentMethods
                                                                  .elementAt(
                                                                      index)
                                                                  .modes
                                                                  .elementAt(
                                                                      insideIndex)
                                                                  .code)
                                                          ? Colors.white
                                                          : Palette
                                                              .secondaryColor),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        }),
                  ),
                ],
              ), // Submit Button

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (widget.selectedPaymentMethod != 0) {
                          widget.onAction(
                              GetSelectPayment(widget.selectedPaymentMethod));
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        color: Colors.black,
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: Center(
                          child: Text(
                            Strings.submit,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetPromoCode extends StatefulWidget {
  final String authID;
  final double payingAmount;
  final int paymentMode;
  final String orderID;
  final String razorpayOrderID;
  final String deliveryAddressID;
  final double deliveryCharges;
  final List<String> cartKeys;
  final double walletAmount;
  final double taxAmount;
  final double totalPayingAmount;
  String promoCode = "";
  TextEditingController textEditingController;

  GetPromoCode({
    Key key,
    this.authID,
    this.orderID,
    this.razorpayOrderID,
    this.payingAmount,
    this.paymentMode,
    this.deliveryAddressID,
    this.deliveryCharges,
    this.cartKeys,
    this.taxAmount,
    this.totalPayingAmount,
    this.walletAmount,
  }) : super(key: key);

  @override
  _GetPromoCodeState createState() => _GetPromoCodeState();
}

class _GetPromoCodeState extends State<GetPromoCode> {
  @override
  Widget build(BuildContext context) {
    widget.textEditingController = new TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BlocBuilder<CheckPromoCodeBloc, PromoCodeAvailabilityState>(
            builder: (context, state) {
          if (state is PromoCodeDetailAvailabilityChecking)
            return Padding(
                padding: EdgeInsets.all(4.0),
                child: CircularProgressIndicator(
                    strokeWidth: 3.0,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.black,
                    )));
          else if (state is PromoCodeDetailAvailabilityCheckingSuccessful)
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black54,
                  style: BorderStyle.solid,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            state.checkPromoCodeAvailability.promoCode,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 16),
                        //   child: Container(
                        //     width: MediaQuery.of(context).size.width * 0.1,
                        //     child: TextFormField(

                        //       // keyboardType: TextInputType,

                        //       // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        //       onChanged: (val) {
                        //         setState(() {
                        //           widget.promoCode = val;
                        //         });
                        //       },
                        //       cursorColor: Colors.blue,

                        //       decoration: InputDecoration(
                        //         labelText: Strings.promoCode,
                        //         border: InputBorder.none,
                        //         labelStyle: TextStyle(color: Colors.black54),
                        //         focusedBorder: InputBorder.none,
                        //         enabledBorder: InputBorder.none,
                        //         errorBorder: InputBorder.none,
                        //         disabledBorder: InputBorder.none,
                        //         counterText: ,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<CheckPromoCodeBloc>(context)
                              .add(RemovePromoCode());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Card(
                            elevation: 3,
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                Strings.remove,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          else if (state is RemovePromoCodeSuccessfull) {
            widget.textEditingController.clear();
            widget.promoCode = '';
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black54,
                  style: BorderStyle.solid,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            height: 50,
                            child: TextFormField(
                              controller: widget.textEditingController,
                              // keyboardType: TextInputType,

                              // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              onChanged: (val) {
                                widget.promoCode = val;
                                // setState(() {
                                //   widget.promoCode = val;
                                // });
                              },
                              cursorColor: Colors.blue,

                              decoration: InputDecoration(
                                labelText: Strings.promoCode,
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.black54),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<CheckPromoCodeBloc>(context).add(
                              CheckingPromoCodeAvailability(
                                  authID: widget.authID,
                                  deliveryCharges: widget.deliveryCharges,
                                  payingAmount: widget.payingAmount,
                                  paymentMode: widget.paymentMode,
                                  promoCode: widget.promoCode,
                                  walletAmount: widget.walletAmount));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Card(
                            elevation: 3,
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                Strings.apply,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.25,
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.black54,
                  style: BorderStyle.solid,
                )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.15,
                            child: TextFormField(
                              controller: widget.textEditingController,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              // keyboardType: TextInputType,

                              // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                              // onChanged: (val) {
                              //   setState(() {
                              //     widget.promoCode = val;
                              //   });
                              // },
                              onChanged: (val) {
                                widget.promoCode = val;
                              },
                              cursorColor: Colors.blue,

                              decoration: InputDecoration(
                                labelText: Strings.promoCode,
                                border: InputBorder.none,
                                labelStyle: TextStyle(color: Colors.black54),
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                counterText: "",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: InkWell(
                        onTap: () {
                          BlocProvider.of<CheckPromoCodeBloc>(context).add(
                              CheckingPromoCodeAvailability(
                                  authID: widget.authID,
                                  deliveryCharges: widget.deliveryCharges,
                                  payingAmount: widget.payingAmount,
                                  paymentMode: widget.paymentMode,
                                  promoCode: widget.promoCode,
                                  walletAmount: widget.walletAmount));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Card(
                            elevation: 3,
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                Strings.apply,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }),

        // Container(
        //   width: MediaQuery.of(context).size.width * 0.23,
        //   padding: EdgeInsets.all(0.0),
        //   margin: EdgeInsets.all(0.0),
        //   child: Divider(
        //     thickness: 1.0,
        //     height: 0.0,
        //     color: Colors.black,
        //   ),
        // ),
        BlocBuilder<CheckPromoCodeBloc, PromoCodeAvailabilityState>(
          builder: (context, state) {
            if (state is PromoCodeDetailAvailabilityChecking)
              return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      )));
            else if (state is PromoCodeDetailAvailabilityCheckingSuccessful)
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.checkPromoCodeAvailability.couponType == 102 ||
                      state.checkPromoCodeAvailability.couponType == 103)
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        state.checkPromoCodeAvailability.responseText,
                        style: TextStyle(
                          color: Palette.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        state.checkPromoCodeAvailability.responseText,
                        style: TextStyle(
                          color: Colors.red[500],
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  if (state.checkPromoCodeAvailability.couponType == 102)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Strings.grandTotal,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              state.checkPromoCodeAvailability.newPayingAmount
                                  .toString(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 8.0,
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              Strings.grandTotal,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              widget.totalPayingAmount.toString(),
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (state.checkPromoCodeAvailability.couponType == 102)
                    ProceedToPayButton(
                      amount: widget.payingAmount,
                      totalAmount:
                          state.checkPromoCodeAvailability.newPayingAmount,
                      authID: widget.authID,
                      orderID:
                          state.checkPromoCodeAvailability.paymentData.orderID,
                      razorpayOrderID: state.checkPromoCodeAvailability
                          .paymentData.razorpayOrderID,
                      paymentMode: widget.paymentMode,
                      deliveryCharges: widget.deliveryCharges,
                      cartKeys: widget.cartKeys,
                      deliveryAddressID: widget.deliveryAddressID,
                      couponCode: widget.promoCode,
                      couponAmount: state.checkPromoCodeAvailability.discount,
                    )
                  else if (state.checkPromoCodeAvailability.couponType == 103)
                    ProceedToPayButton(
                      amount: widget.payingAmount,
                      totalAmount: widget.totalPayingAmount,
                      authID: widget.authID,
                      orderID: widget.orderID,
                      razorpayOrderID: widget.razorpayOrderID,
                      paymentMode: widget.paymentMode,
                      deliveryCharges: widget.deliveryCharges,
                      cartKeys: widget.cartKeys,
                      deliveryAddressID: widget.deliveryAddressID,
                      couponCode: widget.promoCode,
                      couponAmount: state.checkPromoCodeAvailability.discount,
                    )
                  else
                    ProceedToPayButton(
                      amount: widget.payingAmount,
                      totalAmount: widget.totalPayingAmount,
                      authID: widget.authID,
                      orderID: widget.orderID,
                      razorpayOrderID: widget.razorpayOrderID,
                      paymentMode: widget.paymentMode,
                      deliveryCharges: widget.deliveryCharges,
                      cartKeys: widget.cartKeys,
                      deliveryAddressID: widget.deliveryAddressID,
                    ),
                ],
              );
            else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8.0,
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Strings.grandTotal,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.totalPayingAmount.toString(),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProceedToPayButton(
                    amount: widget.payingAmount,
                    totalAmount: widget.totalPayingAmount,
                    authID: widget.authID,
                    orderID: widget.orderID,
                    razorpayOrderID: widget.razorpayOrderID,
                    paymentMode: widget.paymentMode,
                    deliveryAddressID: widget.deliveryAddressID,
                    deliveryCharges: widget.deliveryCharges,
                    cartKeys: widget.cartKeys,
                  ),
                ],
              );
            }
          },
        ),
      ],
    );
  }
}
