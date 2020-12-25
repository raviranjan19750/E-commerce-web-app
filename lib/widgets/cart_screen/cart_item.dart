import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/widgets/widgets.dart';
import '../../bloc/cart/cart_bloc.dart';
import 'dart:math' as math;

class CartItemView extends StatelessWidget {
  final Cart cart;

  const CartItemView({Key key, this.cart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print(cart.colour);
    return BlocProvider(
      create: (context) => CartItemBloc(
        cart: cart,
        cartBloc: RepositoryProvider.of(context),
        cartTotalBloc: BlocProvider.of(context),
        cartRepository: RepositoryProvider.of(context),
      ),
      child: BlocBuilder<CartItemBloc, CartItemState>(
        builder: (context, state) {
          switch (state.type) {
            case CartItemStateType.LOADING:
              return Opacity(
                opacity: 0.5,
                child: IgnorePointer(
                  child: CartItem(
                    cart: state.cart,
                  ),
                ),
              );
            case CartItemStateType.LOADING:
              return Icon(
                Icons.warning,
                color: Colors.red,
              );
            default:
              return CartItem(
                cart: state.cart,
              );
          }
        },
      ),
    );
  }
}

class CustomLeftHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CustomRightHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = new Path();

    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class CartItem extends StatelessWidget {
  final Cart cart;

  const CartItem({Key key, this.cart}) : super(key: key);

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
                      cart.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // isCombo
                  // Positioned(
                  //   right: 0,
                  //   top: 0,
                  //   child: cart.isCombo
                  //       ? Diagonal(
                  //           axis: Axis.vertical,
                  //           position: DiagonalPosition.TOP_LEFT,
                  //           clipHeight:
                  //               MediaQuery.of(context).size.height * 0.03,
                  //           child: Container(
                  //             color: Colors.red[900],
                  //             width: MediaQuery.of(context).size.width * 0.065,
                  //             height: MediaQuery.of(context).size.height * 0.03,
                  //             child: Center(
                  //               child: Padding(
                  //                   padding: const EdgeInsets.only(
                  //                     left: 10.0,
                  //                   ),
                  //                   child: Text(
                  //                     Strings.combo,
                  //                     style: TextStyle(
                  //                       color: Colors.white,
                  //                     ),
                  //                   )),
                  //             ),
                  //           ),
                  //         )
                  //       : SizedBox.shrink(),
                  // ),
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
                                text: cart.name,
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
                                cart.discountPrice.toString(),
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
                            cart.colour.length == 2
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
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(8),
                                              topLeft: Radius.circular(8),
                                            ),
                                            color: cart.colour[0],
                                          ),
                                          height: 16,
                                          width: 8,
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                            ),
                                            color: cart.colour[1],
                                          ),
                                          height: 16,
                                          width: 8,
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
                                      backgroundColor: cart.colour[0],
                                    ),
                                  ),

                            // Stack(
                            //     children: [
                            //       ClipPath(
                            //         clipper:
                            //             new CustomLeftHalfCircleClipper(),
                            //         child: new Container(
                            //           height: 16,
                            //           width: 16,
                            //           decoration: new BoxDecoration(
                            //               color: cart.colour[0],
                            //               borderRadius:
                            //                   BorderRadius.circular(8)),
                            //         ),
                            //       ),
                            //       ClipPath(
                            //         clipper:
                            //             new CustomRightHalfCircleClipper(),
                            //         child: new Container(
                            //           height: 16,
                            //           width: 16,
                            //           decoration: new BoxDecoration(
                            //               color: cart.colour[1],
                            //               borderRadius:
                            //                   BorderRadius.circular(8)),
                            //         ),
                            //       ),
                            //     ],
                            //   )

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
                                      cart.size,
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
                                    quantity: cart.quantity,
                                    documentID: cart.key,
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
                          Strings.rupeesSymbol + cart.sellingPrice.toString(),
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
                          Strings.rupeesSymbol + cart.discountPrice.toString(),
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
                              (cart.sellingPrice - cart.discountPrice)
                                  .toString() +
                              ' (' +
                              (((cart.sellingPrice - cart.discountPrice) /
                                          cart.sellingPrice) *
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
