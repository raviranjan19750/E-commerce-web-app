import 'dart:html';

import 'package:flutter/material.dart';
import 'package:living_desire/config/strings.dart';
import 'package:rating_bar/rating_bar.dart';
import '../../models/models.dart';

class OrderProductItem extends StatelessWidget {
  // OrderedProduct Container
  final OrderedProduct orderedProduct;

  const OrderProductItem({
    Key key,
    this.orderedProduct,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('Order Product Item');
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
                Placeholder(
                  fallbackHeight: 150,
                  fallbackWidth: 110,
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Match the variant id to the actual product
                    Text(
                      orderedProduct.variantID,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                      ),
                    ),
                    // Proie of the product bought
                    Text(
                      orderedProduct.sellingPrice.toString(),
                      style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.lineThrough,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    // Price paid for the product
                    Text(
                      orderedProduct.discountPrice.toString(),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Product Description: quantity, color, size
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //Color
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.blue,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        // Size
                        // Get product Size from variant ID
                        Text(
                          Strings.size,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        // Quantity
                        Text(
                          Strings.quantity +
                              ': ' +
                              orderedProduct.quantity.toString(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Buy Again
                    Container(
                      color: Colors.black,
                      width: 100,
                      height: 35,
                      child: Center(
                        child: InkWell(
                          onTap: () {},
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
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 350,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Need Help Button
                Container(
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
                SizedBox(
                  height: 30,
                ),
                // Rating Bar
                RatingBar(
                  onRatingChanged: (rating) {},
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  isHalfAllowed: false,
                  filledColor: Colors.yellow[700],
                  emptyColor: Colors.black12,
                  size: 23,
                ),
                Container(
                  child: InkWell(
                    onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
