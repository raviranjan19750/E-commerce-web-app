import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/widgets/widgets.dart';
import '../../bloc/cart/cart_bloc.dart';

class CartItem extends StatefulWidget {
  final Cart cart;
  const CartItem({
    Key key,
    this.cart,
  }) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    // Match the Product according to the Product ID in cart
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width * 0.10,
                    child: Image.network(
                      widget.cart.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // isCombo
                  Positioned(
                    right: 0,
                    top: 0,
                    child: widget.cart.isCombo
                        ? Diagonal(
                            axis: Axis.vertical,
                            position: DiagonalPosition.TOP_LEFT,
                            clipHeight:
                                MediaQuery.of(context).size.height * 0.03,
                            child: Container(
                              color: Colors.red[900],
                              width: MediaQuery.of(context).size.width * 0.065,
                              height: MediaQuery.of(context).size.height * 0.03,
                              child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10.0,
                                    ),
                                    child: Text(
                                      Strings.combo,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )),
                              ),
                            ),
                          )
                        : SizedBox.shrink(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width * 0.42,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: RichText(
                              text: TextSpan(
                                text: widget.cart.name,
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
                          Text(
                            Strings.rupeesSymbol +
                                widget.cart.discountPrice.toString(),
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8.0,
                        ),
                        child: Row(
                          children: [
                            //TODO: Color of the product
                            Container(
                              padding: EdgeInsets.all(4.0),
                              margin: EdgeInsets.only(left: 6.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  border: Border.all(
                                      width: 0.5, color: Colors.black)),
                              child: CircleAvatar(
                                radius: 8,
                                backgroundColor: Colors.blue,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.06,
                                child: Row(
                                  children: [
                                    Text(
                                      Strings.size,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      widget.cart.size,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Quantity Button
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5,
                                  )),
                              child: Row(
                                children: [
                                  CartItemCount(
                                    quantity: widget.cart.quantity,
                                    documentID: widget.cart.key,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Old Price
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          top: 4.0,
                        ),
                        child: Text(
                          Strings.rupeesSymbol +
                              widget.cart.sellingPrice.toString(),
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
                          Strings.rupeesSymbol +
                              widget.cart.discountPrice.toString(),
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
                          Strings.youSave +
                              Strings.rupeesSymbol +
                              (widget.cart.sellingPrice -
                                      widget.cart.discountPrice)
                                  .toString() +
                              ' (' +
                              (((widget.cart.sellingPrice -
                                              widget.cart.discountPrice) /
                                          widget.cart.sellingPrice) *
                                      100)
                                  .toInt()
                                  .toString() +
                              '%)',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.green[600],
                          ),
                        ),
                      ),

                      // Remove from Cart
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.end,
                      //   crossAxisAlignment: CrossAxisAlignment.end,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.only(
                      //         top: 4.0,
                      //         left: 8.0,
                      //       ),
                      //       child: InkWell(
                      //         onTap: () {
                      //           BlocProvider.of<CartBloc>(context).add(
                      //               DeleteCart(widget.cart.key, "id1"));
                      //         },
                      //         child: Text(
                      //           Strings.removeCart,
                      //           style: TextStyle(
                      //             color: Colors.red,
                      //             fontWeight: FontWeight.w400,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 0.5,
          color: Colors.black,
        ),
      ],
    );
  }
}
