import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final SelectAddressStateType type;
  String deliveryAddressID;

  SelectAddressCartTotal({
    Key key,
    this.authID,
    this.productID,
    this.variantID,
    this.totalItems,
    this.isSampleRequestedStr,
    this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(type.toString());
    bool isSampleRequested;
    if (isSampleRequested == "true") {
      isSampleRequested = true;
    } else {
      isSampleRequested = false;
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
                  totalItems: state.totalItems as int,
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
  final double deliveryCharges;
  final String authID;
  final String razorpayOrderID;
  final String orderID;
  final double walletAmount;
  final double taxAmount;

  const TotalView({
    Key key,
    this.totalItems,
    this.authID,
    this.totalAmount,
    this.isSampleRequested,
    this.payingAmount,
    this.discount,
    this.deliveryAddressID,
    this.deliveryCharges,
    this.orderID,
    this.razorpayOrderID,
    this.taxAmount,
    this.walletAmount,
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
              child: isSampleRequested == true
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

            isSampleRequested == true
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

            isSampleRequested == true
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

            isSampleRequested == true
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

            SelectPaymentMethod(),

            // Proceed To Pay Button
            isSampleRequested == true
                ? GetQuotationButton()
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
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return SelectPaymentDialog();
            },
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.22,

          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Palette.secondaryColor,
          ),

          // Place Order Button

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

class SelectPaymentDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.6,
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

            // Submit Button
          ],
        ),
      ),
    );
  }
}
