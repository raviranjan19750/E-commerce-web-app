import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../data/data.dart';
import '../../config/configs.dart';

class OrderPlacedItem extends StatelessWidget {
  final OrderedProduct orderedProduct;

  const OrderPlacedItem({
    Key key,
    this.orderedProduct,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get Ordered Product Id and match to product

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Product Image
              //Text('Product Image'),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: Image.network(
                  orderedProduct.imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(orderedProduct.productName),
                      Text(orderedProduct.discountPrice.toString()),
                    ],
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
                        // Get Size from product variants
                        Text(Strings.size),
                        SizedBox(
                          width: 15,
                        ),

                        // Order product Quantity
                        Text(Strings.qty + orderedProduct.quantity.toString()),
                      ],
                    ),
                  ),
                ],
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
