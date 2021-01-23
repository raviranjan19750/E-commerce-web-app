import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/widgets/home_widget/view_all_card.dart';
import 'package:living_desire/widgets/labeltag/label_tag.dart';

import '../nextListHover.dart';

class HomeWidget extends StatelessWidget {
  final List<Product> productlist;
  String labelText;

  // final ScrollController controller = ScrollController();

  HomeWidget({Key key, this.productlist, this.labelText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController homeWidgetScrollController = new ScrollController();

    homeWidgetProductMoveRight() {
      homeWidgetScrollController.animateTo(
          homeWidgetScrollController.offset +
              MediaQuery.of(context).size.width * 0.85,
          curve: Curves.linear,
          duration: Duration(milliseconds: 700));
    }

    homeWidgetMoveLeft() {
      homeWidgetScrollController.animateTo(
          homeWidgetScrollController.offset -
              MediaQuery.of(context).size.width * 0.85,
          curve: Curves.linear,
          duration: Duration(milliseconds: 700));
    }

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
        Container(
            child: LabelTag(
          labelText,
        )),
        Container(
          margin: EdgeInsets.only(top: 16.0),
          // height: 350,
          height: MediaQuery.of(context).size.height / 2.5,
          width: MediaQuery.of(context).size.width / 0.75,
          child: Stack(
            children: [
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: homeWidgetScrollController,
                  itemCount: this.productlist.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == this.productlist.length) {
                      return Container(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.width * 0.15,
                          child: ViewAllCard(
                            routeString: labelText,
                          ));
                    }
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
                  height: 100.0,
                  right: 0,
                  top: 125.0,
                  child: FlatButton(
                    onPressed: () {
                      homeWidgetProductMoveRight();
                    },
                    child: NextListHover(),
                  )),
              Positioned(
                  height: 100.0,
                  left: 0,
                  top: 125.0,
                  child: FlatButton(
                    onPressed: () {
                      homeWidgetMoveLeft();
                    },
                    child: NextListHover(
                      icon: Icons.arrow_back_ios,
                    ),
                  ))
            ],
          ),
          // child: ListView(),
        ),
      ],
    );
  }
}
