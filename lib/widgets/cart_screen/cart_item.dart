import 'package:flutter/material.dart';
import 'package:living_desire/models/models.dart';

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
  Widget _incrementButton(index) {
    return RaisedButton(
      child: Icon(
        Icons.add,
        color: Colors.black,
        size: 16,
      ),
      color: Colors.white,
      onPressed: () {},
    );
  }

  Widget _decrementButton(double index) {
    return RaisedButton(
      onPressed: () {},
      child: Text(
        '-',
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      color: Colors.white,
    );
  }

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
                          children: [
                            Text(widget.cart.name.toString()),
                            Text(widget.cart.discountPrice.toString()),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            //TODO: Color of the product
                            CircleAvatar(
                              backgroundColor: Colors.black,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(widget.cart.size),
                            SizedBox(
                              width: 15,
                            ),

                            // Quantity Button
                            _decrementButton(widget.cart.quantity),
                            Text(
                              '${widget.cart.quantity}',
                              style: TextStyle(fontSize: 16.0),
                            ),
                            _incrementButton(widget.cart.quantity),
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
                      Text('You saved ' +
                          (widget.cart.sellingPrice - widget.cart.discountPrice)
                              .toString()),
                      // Remove from Cart
                      FlatButton(
                        onPressed: () {},
                        child: Text('Remove from Cart'),
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
