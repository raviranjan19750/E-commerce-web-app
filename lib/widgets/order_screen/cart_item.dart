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
    // Match the Product according to the Product ID in cart
    final Product product = Product(
      name: 'ksvlnl',
      currentPrice: 34345,
      previousPrice: 3245,
      discount: 34,
    );
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Row(
              children: [
                // Product Image
                Text('Product Image'),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text(product.name),
                            Text(product.currentPrice.toString()),
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
                            DropdownButton<String>(
                              // Size of the product
                              value: 'S',
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 12,
                              elevation: 5,
                              style: TextStyle(color: Colors.black),
                              onChanged: (String newValue) {},
                              // Get Size variants
                              items: <String>[
                                'S',
                                'M',
                                'L',
                                'XL'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
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
                        'Old Proce',
                      ),
                      // New Price
                      Text('New Price'),
                      // Discount
                      Text('You saved...'),
                      // Remove from Cart
                      FlatButton(
                        onPressed: () {},
                        child: Text('Remove from Cart'),
                      ),
                    ],
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
      ),
    );
  }
}
