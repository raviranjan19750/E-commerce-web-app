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
    print('cart item');
    // Match the Product according to the Product ID in cart
    print(widget.cart.name.toString());
    return Column(
      children: [
        Container(
          child: Row(
            children: [
              // Product Image
              Text('Product Image'),
              Container(
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.cart.name.toString(),
                              style: TextStyle(
                                fontSize: 24,
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
                      ),
                      Container(
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
                                radius: 10,
                                backgroundColor: Colors.blue,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(widget.cart.size),
                            SizedBox(
                              width: 15,
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
                      Text(
                        widget.cart.sellingPrice.toString(),
                      ),
                      // New Price
                      Text(widget.cart.discountPrice.toString()),
                      // Discount
                      Text(Strings.youSaved +
                          Strings.rupeesSymbol +
                          (widget.cart.sellingPrice - widget.cart.discountPrice)
                              .toString()),
                      // Remove from Cart
                      FlatButton(
                        onPressed: () {
                          BlocProvider.of<CartBloc>(context)
                              .add(DeleteCart(widget.cart.key, "id1"));
                        },
                        child: Text(
                          Strings.removeCart,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Divider(
          thickness: 0.5,
          color: Colors.black,
        ),
      ],
    );
  }
}
