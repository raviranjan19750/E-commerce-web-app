import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/check_promo_code/check_promo_code_bloc.dart';
import 'package:living_desire/bloc/select_address/select_address_bloc.dart';
import 'package:living_desire/bloc/select_address_type/select_address_type_bloc.dart';
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
                  razorpayOrderID:
                      state.buyNowDetails.paymentData.razorpayOrderID,
                  orderID: state.buyNowDetails.paymentData.orderID,
                  taxAmount: state.buyNowDetails.taxAmount,
                  walletAmount: state.buyNowDetails.walletAmount,
                );
              } else if (state is NormalCartDetailLoadingSuccessfull) {
                return TotalView(
                  authID: authID,
                  deliveryCharges: state.normalCartDetails.deliveryCharges,
                  discount: state.normalCartDetails.discount,
                  payingAmount: state.normalCartDetails.payingAmount,
                  totalAmount: state.normalCartDetails.totalAmount,
                  totalItems: state.normalCartDetails.totalItems,
                  razorpayOrderID:
                      state.normalCartDetails.paymentData.razorpayOrderID,
                  orderID: state.normalCartDetails.paymentData.orderID,
                  taxAmount: state.normalCartDetails.taxAmount,
                  walletAmount: state.normalCartDetails.walletAmount,
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
              return Container();
            },
          ),
        );
      }
      return Container();
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
  final String orderID;
  final double walletAmount;
  final String totalBulkItems;
  final double taxAmount;

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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 8.0,
              ),
              child: isBulkOrderCart == true
                  ? Row(
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
                    )
                  : Row(
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

            isBulkOrderCart == true
                ? SizedBox.fromSize()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(Strings.deliveryCharges),
                        Text(deliveryCharges.toString()),
                      ],
                    ),
                  ),

            isBulkOrderCart == true
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(Strings.discount),
                        Text(discount.toString()),
                      ],
                    ),
                  ),

            Divider(
              color: Colors.black,
              thickness: 0.3,
            ),

            isBulkOrderCart == true
                ? SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Strings.total,
                          style: TextStyle(fontSize: 18),
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

            SizedBox(
              height: 20,
            ),

            // BlocListener(
            //   listener: (context, state) {
            //     if (state is LaunchSelectPaymentDialog) {
            //       return showDialog(
            //         context: context,
            //         builder: (BuildContext context) {
            //           return SelectPaymentDialog(
            //             onAction: (val) =>
            //                 BlocProvider.of<SelectAddressTypeBloc>(context)
            //                     .add(val),
            //           );
            //         },
            //       );
            //     }
            //   },
            //   child: BlocBuilder(builder: null),
            // ),

            // Select Payment Method
            BlocConsumer<SelectAddressTypeBloc, SelectAddressTypeState>(
              listener: (context, state) {
                if (state is LaunchSelectPaymentDialog) {
                  return showDialog(
                    context: context,
                    builder: (BuildContext buildContext) {
                      return SelectPaymentDialog(
                        onAction: (val) =>
                            BlocProvider.of<SelectAddressTypeBloc>(context)
                                .add(val),
                      );
                    },
                  );
                }
              },
              buildWhen: (previous, current) {
                if (current is SelectAddressTypeState) {
                  return false;
                } else {
                  return true;
                }
              },
              builder: (context, state) {
                if (state is PaymentMethodLoadingSuccessfull) {
                  return Container(
                    width: 30,
                    height: 30,
                    color: Colors.red,
                    child: Text(state.paymentMode.toString()),
                  );
                }

                return isBulkOrderCart == true
                    ? SizedBox.shrink()
                    : SelectPaymentMethod();
              },
            ),

            // Promo Code
            isBulkOrderCart == true
                ? SizedBox.shrink()
                : GetPromoCode(
                    authID: authID,
                    payingAmount: payingAmount,
                    // paymentMode: paymentMode,
                  ),

            // Proceed To Pay Button
            isBulkOrderCart == true
                ? GetQuotationButton(
                    authID: authID,
                    deliveryAddressID: deliveryAddressID,
                    isSampleRequested: isSampleRequested,
                  )
                : ProceedToPayButton(
                    amount: payingAmount,
                    authID: authID,
                  ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Strings.selectAddressNextStep,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
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
          ],
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
          BlocProvider.of<SelectAddressTypeBloc>(context)
              .add(LoadSelectPaymentDialog());
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.22,
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

  const SelectPaymentDialog({Key key, this.onAction}) : super(key: key);
  @override
  _SelectPaymentDialogState createState() => _SelectPaymentDialogState();
}

class _SelectPaymentDialogState extends State<SelectPaymentDialog> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex;
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
                    label: Text('Debit Card'),
                    selected: selectedIndex == 1,
                    elevation: 10,
                    pressElevation: 5,
                    selectedShadowColor: Colors.blue,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.black54,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedIndex = 1;
                          print(selectedIndex);
                        }
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('Credit Card'),
                    selected: selectedIndex == 2,
                    elevation: 10,
                    pressElevation: 5,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.black54,
                    selectedColor: Colors.red,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedIndex = 2;
                          print(selectedIndex);
                        }
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('Netbanking'),
                    selected: selectedIndex == 3,
                    elevation: 10,
                    pressElevation: 5,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.black54,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          selectedIndex = 3;
                          print(selectedIndex);
                        }
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('UPI'),
                    selected: selectedIndex == 4,
                    elevation: 10,
                    pressElevation: 5,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.black54,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      print(selectedIndex);

                      setState(() {
                        if (selected) {
                          selectedIndex = 4;
                        }
                      });
                    },
                  ),
                  ChoiceChip(
                    label: Text('Wallet'),
                    selected: selectedIndex == 5,
                    elevation: 10,
                    pressElevation: 5,
                    shadowColor: Colors.teal,
                    backgroundColor: Colors.black54,
                    selectedColor: Colors.blue,
                    onSelected: (bool selected) {
                      print(selectedIndex);
                      setState(() {
                        if (selected) {
                          selectedIndex = 5;
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
                      widget.onAction(
                        PaymentMethod(
                          paymentMode: selectedIndex,
                        ),
                      );
                      Navigator.of(context).pop();
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

class GetPromoCode extends StatelessWidget {
  final String authID;
  final double payingAmount;
  final int paymentMode;

  const GetPromoCode(
      {Key key, this.authID, this.payingAmount, this.paymentMode})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String promoCode;

    TextEditingController textEditingController;

    textEditingController = TextEditingController();

    promoCode = "";

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckPromoCodeBloc(
              promoCodeRepository: RepositoryProvider.of(context))
            ..add(CheckingPromoCodeAvailabilityInitial()),
        ),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.code,
                color: Colors.black,
              ),
              Container(
                width: 130,
                margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
                child: TextFormField(
                    controller: textEditingController,
                    // keyboardType: TextInputType,
                    maxLength: 6,
                    // inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (val) {
                      promoCode = val;
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        labelText: Strings.checkAvailability,
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.black54),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        counterText: "")),
              ),
              InkWell(
                onTap: () {
                  BlocProvider.of<CheckPromoCodeBloc>(context).add(
                      CheckingPromoCodeAvailability(
                          authID, payingAmount, paymentMode, promoCode));
                },
                child: Text(
                  Strings.check,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          Container(
            width: 230,
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
                    if (state.checkPromoCodeAvailability.responseCode == 200)
                      Text(
                        'Promo Code Applied New Amount:',
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
                      )
                    // else if (state.checkPromoCodeAvailability.responseCode ==
                    //     501)
                    //   Text(
                    //     Strings.notAvailable.toUpperCase(),
                    //     style: TextStyle(
                    //         color: Colors.red[500],
                    //         fontWeight: FontWeight.normal,
                    //         fontSize: 14),
                    //   )
                    // else
                    //   Text(
                    //     Strings.invalidPincode.toUpperCase(),
                    //     style: TextStyle(
                    //         color: Colors.orange,
                    //         fontWeight: FontWeight.normal,
                    //         fontSize: 14),
                    //   ),
                  ],
                );
              else if (state is PromoCodeDetailAvailabilityCheckingFailure)
                return Container(
                  child: Text(
                    "Error",
                  ),
                );
              else {
                return Container();
              }
            },
          ),
        ],
      ),
      // Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     child: Row(
      //       children: [
      //         Expanded(
      //           child: TextFormField(
      //             decoration: InputDecoration(
      //               labelText: 'Enter your Promo Code Here',
      //               //border: InputBorder.none,
      //               labelStyle: TextStyle(color: Colors.blue),
      //               // focusedBorder: InputBorder.none,
      //               // enabledBorder: InputBorder.none,
      //               // errorBorder: InputBorder.none,
      //               // disabledBorder: InputBorder.none,
      //             ),
      //             cursorColor: Colors.black,
      //             // initialValue: initialValue,
      //             // validator: validator,
      //             onSaved: (val) {},
      //             onChanged: (val) {},
      //           ),
      //         ),
      //         InkWell(
      //           onTap: () {},
      //           child: Text(
      //             'APPLY',
      //             style: TextStyle(
      //               color: Colors.blue,
      //               fontSize: 14,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
