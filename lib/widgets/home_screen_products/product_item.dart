import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import '../../models/models.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.all(8.0),

      child: FlatButton(
        onPressed: () {
          //Navigator.of(context).pushNamed(routeName);
        },
        child:  Container(
          height: double.infinity,
          width: 200.0,
          color: Palette.maroon,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Add Product Image from firebase

              Text(product.name,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16
                  ),

              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Container(

                      child: Text(
                        product.currentPrice.toString(),
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
                      child: Text(
                        product.previousPrice.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        product.discount.toString() + "% Off",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Palette.green,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Add other Information
            ],
          ),
        ),

      ),
    );
  }
}
