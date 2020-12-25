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
                Container(
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
                      // Proie of the product bought
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              top: 4.0,
                            ),
                            child: Text(
                              Strings.rupeesSymbol +
                                  orderedProduct.sellingPrice.toString(),
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
                                  orderedProduct.discountPrice.toString(),
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
                                  (orderedProduct.sellingPrice -
                                          orderedProduct.discountPrice)
                                      .toString() +
                                  ' (${(((orderedProduct.sellingPrice - orderedProduct.discountPrice) / orderedProduct.sellingPrice) * 100).toInt()}%)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.green[600],
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Product Description: quantity, color, size
                      Padding(
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
                            Container(
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
                                backgroundColor: Colors.blue,
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
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
                      ),

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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 15.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      RatingBar(
                        onRatingChanged: (rating) {},
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        isHalfAllowed: false,
                        filledColor: Colors.yellow[700],
                        emptyColor: Colors.black12,
                        size: MediaQuery.of(context).size.width * 0.013,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
