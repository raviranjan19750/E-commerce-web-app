import 'package:flutter/material.dart';
import 'package:living_desire/config/palette.dart';
import '../../models/models.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({
    Key key,
    @required this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FlatButton(
        onPressed: () {
          //Navigator.of(context).pushNamed(routeName);
        },
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  //height: MediaQuery.of(context).size.height*0.25,
                  width: 250.0,
                  color: Palette.lightGrey,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    color: Palette.lightGrey,
                  )),
              Container(
                padding: EdgeInsets.only(
                    left: 0.0, top: 12.0, right: 0.0, bottom: 0.0),
                child: Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: 0.0, top: 4.0, right: 0.0, bottom: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: Text(
                        product.retailPrice.toString(),
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
                      child: Text(
                        product.retailPrice.toString(),
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                    Container(
                      child: Text(
                        product.discountPrice.toString() + "% Off",
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
            ],
          ),
        ),
      ),
    );
  }
}
