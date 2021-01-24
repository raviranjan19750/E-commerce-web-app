import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:living_desire/widgets/widgets.dart';

import '../../main.dart';
import '../../routes.dart';

class CartItemView extends StatelessWidget {
  final Cart cart;

  const CartItemView({Key key, this.cart}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Bloc Provider to cart item bloc
    // Gets cart items in state

    // Cart Item Bloc:
    // Cart Bloc
    // Cart Total Bloc
    // Cart Repository: http requests , carts local repository

    return BlocProvider(
      create: (context) => CartItemBloc(
        cart: cart,
        cartBloc: RepositoryProvider.of(context),
        cartTotalBloc: BlocProvider.of(context),
        cartRepository: RepositoryProvider.of(context),
      ),
      // Get state of cart items
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
              // Cart Item Container
              return CartItem(
                cart: state.cart,
              );
          }
        },
      ),
    );
  }
}

// Cart Item Class
class CartItem extends StatelessWidget {
  final Cart cart;

  const CartItem({Key key, this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Match the Product according to the Product ID in cart
    //
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12.0,
          ),
          child: InkWell(
            onTap: () {
              locator<NavigationService>()
                  .navigateTo(RoutesConfiguration.PRODUCT_DETAIL, queryParams: {
                "pid": cart.productID,
                "vid": cart.variantID,
              });
            },
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
                            // Cart Item Name
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
                            // Cart Discount Price
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
                              //Color of the product
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
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                topLeft: Radius.circular(8),
                                              ),
                                              color: cart.colour[0],
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
                                              color: cart.colour[1],
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
                                        backgroundColor: cart.colour[0],
                                      ),
                                    ),

                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.06,
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
                                      productID: cart.productID,
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
                            Strings.rupeesSymbol +
                                cart.discountPrice.toString(),
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
        ),
        Divider(
          thickness: 0.5,
          color: Colors.black,
        ),
      ],
    );
  }
}
