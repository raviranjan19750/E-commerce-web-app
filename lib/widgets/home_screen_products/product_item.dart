import 'package:flutter/material.dart';
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
        child: Container(
          height: double.infinity,
          width: 100.0,
          color: Colors.red,
          child: Column(
            children: [
              // Add Product Image from firebase
              Text("product na,e"),
              Text('price'),
              // Add other Information
            ],
          ),
        ),
      ),
    );
  }
}
