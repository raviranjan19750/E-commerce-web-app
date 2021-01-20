import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/check_promo_code/check_promo_code_bloc.dart';
import 'package:living_desire/bloc/select_address/select_address_bloc.dart';
import 'package:living_desire/bloc/select_address_type/select_address_type_bloc.dart';
import 'package:living_desire/bloc/select_payment/select_payment_bloc.dart';
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
                  totalPayingAmount: state.normalCartDetails.totalPayingAmount,
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
                              totalAmount.toString(),
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
                              discount.toString(),
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
                              payingAmount.toString(),
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
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        state
                                            .checkPromoCodeAvailability.discount
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
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
                                        state
                                            .checkPromoCodeAvailability.discount
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
                                        '0',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        state
                                            .checkPromoCodeAvailability.discount
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
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
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '0',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
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
                                    state.checkPromoCodeAvailability.taxAmount
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
                                    Strings.tax,
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
                                taxAmount.toString(),
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
                              deliveryCharges.toString(),
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
                              walletAmount.toString(),
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
                  : SelectPaymentMethod(),

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
                    if (state.paymentMode == 1) {
                      paymentMode = 101;
                    } else if (state.paymentMode == 2) {
                      paymentMode = 102;
                    } else if (state.paymentMode == 3) {
                      paymentMode = 103;
                    } else if (state.paymentMode == 4) {
                      paymentMode = 104;
                    } else if (state.paymentMode == 5) {
                      paymentMode = 105;
                    }
                    return GetPromoCode(
                      authID: authID,
                      payingAmount: payingAmount,
                      paymentMode: paymentMode,
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
  SelectPaymentDialog({Key key, this.onAction}) : super(key: key);
  @override
  _SelectPaymentDialogState createState() => _SelectPaymentDialogState();
}

class _SelectPaymentDialogState extends State<SelectPaymentDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Select Payment Method
              Text(
                Strings.selectPaymentMethod,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ChoiceChip(
                    label: Container(
                      child: Row(
                        children: [
                          Ink.image(
                            image: AssetImage('assets/images/debit_card.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Text('Debit Card'),
                              Text('Visa, MasterCard, ...etc.')
                            ],
                          ),
                        ],
                      ),
                    ),
                    selected: widget.selectedIndex == 1,
                    elevation: 10,
                    pressElevation: 5,
                    selectedShadowColor: Colors.blue,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          widget.selectedIndex = 1;
                        }
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Container(
                      child: Row(
                        children: [
                          Ink.image(
                            image: AssetImage('assets/images/credit_card.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Text('Credit Card'),
                              Text('Visa, MasterCard, ...etc.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    selected: widget.selectedIndex == 2,
                    elevation: 10,
                    pressElevation: 5,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.white,
                    selectedColor: Colors.red,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          widget.selectedIndex = 2;
                        }
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Container(
                      child: Row(
                        children: [
                          Ink.image(
                            image: AssetImage('assets/images/netbanking.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Text('Netbanking'),
                              Text('HDFC, SBI, ICICI ...etc.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    selected: widget.selectedIndex == 3,
                    elevation: 10,
                    pressElevation: 5,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          widget.selectedIndex = 3;
                        }
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Container(
                      child: Row(
                        children: [
                          Ink.image(
                            image: AssetImage('assets/images/upi.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Text('UPI'),
                              Text('Paytm, Gpay, Phonepe, ...etc.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    selected: widget.selectedIndex == 4,
                    elevation: 10,
                    pressElevation: 5,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          widget.selectedIndex = 4;
                        }
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Container(
                      child: Row(
                        children: [
                          Ink.image(
                            image: AssetImage('assets/images/wallet.png'),
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                          Column(
                            children: [
                              Text('Wallet'),
                              Text('PAYTM, ...etc.'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    selected: widget.selectedIndex == 5,
                    elevation: 10,
                    pressElevation: 5,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.white,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          widget.selectedIndex = 5;
                        }
                      });
                    },
                  ),
                ],
              ),

              // Submit Button

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      if (widget.selectedIndex != null) {
                        widget.onAction(GetSelectPayment(widget.selectedIndex));
                        Navigator.of(context).pop();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Text(Strings.submit),
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
    TextEditingController textEditingController;

    textEditingController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code,
                color: Colors.black,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                child: TextFormField(
                  controller: textEditingController,
                  // keyboardType: TextInputType,

                  // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (val) {
                    setState(() {
                      widget.promoCode = val;
                    });
                  },
                  cursorColor: Colors.black,
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
              InkWell(
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
                child: Text(
                  Strings.apply,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.23,
          padding: EdgeInsets.all(0.0),
          margin: EdgeInsets.all(0.0),
          child: Divider(
            thickness: 1.0,
            height: 0.0,
            color: Colors.black,
          ),
        ),
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
                    Text(
                      state.checkPromoCodeAvailability.responseText,
                      style: TextStyle(
                        color: Palette.green,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    )
                  else
                    Text(
                      state.checkPromoCodeAvailability.responseText,
                      style: TextStyle(
                        color: Colors.red[500],
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
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
                      amount: state.checkPromoCodeAvailability.newPayingAmount,
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
                      amount: widget.totalPayingAmount,
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
                      amount: widget.totalPayingAmount,
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
            else if (state is PromoCodeDetailAvailabilityCheckingFailure)
              return Container(
                child: Text(
                  "Error",
                ),
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
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.totalPayingAmount.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ProceedToPayButton(
                    amount: widget.totalPayingAmount,
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
