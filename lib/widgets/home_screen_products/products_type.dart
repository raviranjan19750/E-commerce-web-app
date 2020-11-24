import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/widgets/widgets.dart';
import '../../models/models.dart';

class ProductsType extends StatelessWidget {
  final ProductType productType;

  const ProductsType({
    Key key,
    this.productType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Products List
    final List<Product> products = product;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          child: Divider(
            color: Colors.black54,
            thickness: 0.5,
          ),
        ),

        ClipPath(
          clipper: BackgroundClipper(),
          child:  Container(

            width: 100,
            height: 50,
            color: Palette.maroon,

            child: Text(productType.type),
          ),
        ),

        FlatButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(productType.type),
              const SizedBox(
                width: 10.0,
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),

        Container(
          height: MediaQuery.of(context).size.height*0.28,

          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductItem(
                product: products[index],
              );
            },
          ),
        ),
      ],
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    var roundnessFactor = 50.0;
    var path = Path();


    return path;

    throw UnimplementedError();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
   // throw UnimplementedError();
  }
}

