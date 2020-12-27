import 'package:flutter/material.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';

import '../nextListHover.dart';

class HomeWidget extends StatelessWidget {
  final List<Product> productlist;
  final String labeltxt;

  const HomeWidget({Key key, this.productlist, this.labeltxt})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
        ),
        LabelTag(this.labeltxt),
        Container(
          margin: EdgeInsets.only(top: 16.0),
          height: 350,
          child: Stack(
            children: [
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: this.productlist.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      child: ProductCard(
                        product: this.productlist[index],
                      ),
                    );
                  }),
              Positioned(
                  height: 175,
                  right: 0,
                  child: FlatButton(
                    onPressed: () {},
                    child: NextListHover(),
                  ))
            ],
          ),
          // child: ListView(),
        ),
      ],
    );
  }
}
