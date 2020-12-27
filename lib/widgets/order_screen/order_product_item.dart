import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';
import 'package:living_desire/bloc/normal_order/normal_order_bloc.dart';
import 'package:living_desire/bloc/normal_order_item/normal_order_item_bloc.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/widgets/widgets.dart';
import 'package:rating_bar/rating_bar.dart';
import '../../models/models.dart';

class OrderProductItemView extends StatelessWidget {
  // OrderedProduct Container
  final OrderedProduct orderedProduct;
  final String orderID;

  const OrderProductItemView({
    Key key,
    this.orderID,
    this.orderedProduct,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Bloc Provider to order item bloc
    // Gets order items in state

    // Order Item Bloc:
    // Order Bloc
    // Order Repository: http requests , order local repository

    return BlocProvider(
      create: (context) => NormalOrderItemBloc(
        normalOrderBloc: RepositoryProvider.of(context),
        normalOrderRepository: RepositoryProvider.of(context),
        orderedProduct: orderedProduct,
      ),
      child: BlocConsumer<NormalOrderItemBloc, NormalOrderItemState>(
        listener: (context, state) {
          if (state is LaunchAddRatingDialogueState) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext buildContext) {
                //print('Dialog');
                return RatingDialogContainer(
                    isAddRating: true,
                    orderID: orderID,
                    orderedProduct: orderedProduct,
                    onActionButton: (val) {
                      BlocProvider.of<NormalOrderItemBloc>(context).add(val);
                      Navigator.pop(context);
                    });
              },
            );
          } else if (state is LaunchEditRatingDialogueState) {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext buildContext) {
                  return RatingDialogContainer(
                    isEditrating: true,
                    orderedProduct: orderedProduct,
                    onActionButton: (val) {
                      BlocProvider.of<NormalOrderItemBloc>(context).add(val);
                      Navigator.of(context).pop();
                    },
                  );
                });
          }
        },
        buildWhen: (prev, curr) {
          if (curr is ManageDialogueState) {
            return false;
          } else {
            return true;
          }
        },
        builder: (context, state) {
          switch (state.type) {
            case NormalOrderItemStateType.LOADING:
              return Opacity(
                opacity: 0.5,
                child: IgnorePointer(
                  child: OrderProductItem(
                    orderID: orderID,
                    orderedProduct: state.orderedProduct,
                  ),
                ),
              );
            case NormalOrderItemStateType.LOADING:
              return Icon(
                Icons.warning,
                color: Colors.red,
              );
            default:
              return OrderProductItem(
                orderID: orderID,
                orderedProduct: state.orderedProduct,
              );
          }
        },
      ),
    );
  }
}

class OrderProductItem extends StatelessWidget {
  final OrderedProduct orderedProduct;
  final String orderID;

  const OrderProductItem({
    Key key,
    this.orderedProduct,
    this.orderID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          top: 10,
          bottom: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Image
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width * 0.12,
                  child: Image.network(
                    orderedProduct.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                OrderedProductDetails(
                  orderedProduct: orderedProduct,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Need Help Button
                Padding(
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 15.0,
                  ),
                  child: Container(
                    child: InkWell(
                      onTap: () {},
                      child: Text(
                        Strings.needHelp,
                        style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),

                // Rating Bar
                OrderedProductRating(
                  orderID: orderID,
                  orderedProduct: orderedProduct,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderedProductRating extends StatelessWidget {
  final OrderedProduct orderedProduct;
  final String orderID;
  const OrderedProductRating({
    this.orderedProduct,
    this.orderID,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          orderedProduct.rating != null
              ? RatingBar(
                  onRatingChanged: (ratingValue) {
                    // Show Dialog
                    // pass rating parameters
                  },
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  isHalfAllowed: false,
                  initialRating: orderedProduct.rating.rating,
                  filledColor: Colors.yellow[700],
                  emptyColor: Colors.black12,
                  size: MediaQuery.of(context).size.width * 0.013,
                )
              : SizedBox.shrink(),
          Container(
            child: InkWell(
              onTap: () {
                // Show rating dialog
                // if (orderedProduct.rating != null) {
                //   BlocProvider.of<NormalOrderBloc>(context)
                //       .add(LoadAddRatingDialogueEvent());
                // }

                BlocProvider.of<NormalOrderItemBloc>(context)
                    .add(LoadAddRatingDialogueEvent());

                // showDialog(
                //     barrierDismissible: false,
                //     context: context,
                //     builder: (BuildContext buildContext) {
                //       return RatingDialogContainer(
                //         orderedProduct: orderedProduct,
                //       );
                //     });
              },
              child: Text(
                Strings.rate,
                style: TextStyle(
                  color: Colors.orange,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderedProductDetails extends StatelessWidget {
  const OrderedProductDetails({
    Key key,
    @required this.orderedProduct,
  }) : super(key: key);

  final OrderedProduct orderedProduct;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: RichText(
              text: TextSpan(
                text: orderedProduct.productName,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.w500,
                ),
              ),
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(
                fontWeight: FontWeight.w600,
                fontSize: 25,
              ),
            ),
          ),
          // Price of the product bought
          OrderedProductPrice(orderedProduct: orderedProduct),

          // Product Description: quantity, color, size
          OrderedProductDescription(orderedProduct: orderedProduct),

          // Buy Again
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('/product');
              },
              child: Container(
                color: Colors.black,
                width: MediaQuery.of(context).size.width * 0.1,
                height: MediaQuery.of(context).size.height * 0.05,
                child: Center(
                  child: Text(
                    Strings.buyAgain,
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
    );
  }
}

class OrderedProductDescription extends StatelessWidget {
  const OrderedProductDescription({
    Key key,
    @required this.orderedProduct,
  }) : super(key: key);

  final OrderedProduct orderedProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //Color
          orderedProduct.colour.length == 2
              ? Container(
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.only(left: 6.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          color: orderedProduct.colour[0],
                        ),
                        height: 8,
                        width: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          color: orderedProduct.colour[1],
                        ),
                        height: 8,
                        width: 16,
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.only(left: 6.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: orderedProduct.colour[0],
                  ),
                ),

          // Size
          // Get product Size from variant ID
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Text(
                  Strings.size,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  orderedProduct.size,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 15,
          ),
          // Quantity
          Text(
            Strings.quantity,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w500, color: Colors.grey),
          ),
          Text(
            orderedProduct.quantity.toString(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class OrderedProductPrice extends StatelessWidget {
  const OrderedProductPrice({
    Key key,
    @required this.orderedProduct,
  }) : super(key: key);

  final OrderedProduct orderedProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 8.0,
            top: 4.0,
          ),
          child: Text(
            Strings.rupeesSymbol + orderedProduct.sellingPrice.toString(),
            style: TextStyle(
              fontSize: 14,
              decoration: TextDecoration.lineThrough,
              fontWeight: FontWeight.w300,
              color: Colors.grey,
            ),
          ),
        ),
        // Price paid for the product
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 8.0,
          ),
          child: Text(
            Strings.rupeesSymbol + orderedProduct.discountPrice.toString(),
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 4.0,
            left: 8.0,
          ),
          child: Text(
            Strings.youSaved +
                Strings.rupeesSymbol +
                (orderedProduct.sellingPrice - orderedProduct.discountPrice)
                    .toString() +
                ' (${(((orderedProduct.sellingPrice - orderedProduct.discountPrice) / orderedProduct.sellingPrice) * 100).toInt()}%)',
            style: TextStyle(
              fontSize: 14,
              color: Colors.green[600],
            ),
          ),
        ),
      ],
    );
  }
}
