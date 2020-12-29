import 'package:flutter/material.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';

import '../nextListHover.dart';

class ProductCategoryCard extends StatelessWidget {
  final String productCategory;

  const ProductCategoryCard({Key key, this.productCategory}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ProductCategoryCardContent(
        prodCat: this.productCategory,
      ),
    );
  }
}

class ProductCategoryCardContent extends StatelessWidget {
  final String prodCat;

  const ProductCategoryCardContent({Key key, this.prodCat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: InkWell(
                onTap: () {
                  // Navigator.pushNamed(
                  //     context, RoutesConfiguration.PRODUCT_DETAIL,
                  //     arguments: {
                  //       "product": product,
                  //       "productID": product.productId,
                  //       "variantID": product.varientId
                  //     });
                },
                child: Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        this.prodCat,
                        style: TextStyle(fontSize: 30),
                      ),
                      Icon(Icons.navigate_next_sharp)
                    ],
                  )),
                )),
          ),
        )
      ],
    );
  }
}

class ProductCategoryWidget extends StatelessWidget {
  final List<String> catList;

  const ProductCategoryWidget({Key key, this.catList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController productCategoryWidgetScrollController =
        new ScrollController();

    productCategoryWidgetMoveRight() {
      productCategoryWidgetScrollController.animateTo(
          productCategoryWidgetScrollController.offset +
              MediaQuery.of(context).size.width * 0.85,
          curve: Curves.linear,
          duration: Duration(milliseconds: 700));
    }

    productCategoryWidgetMoveLeft() {
      productCategoryWidgetScrollController.animateTo(
          productCategoryWidgetScrollController.offset -
              MediaQuery.of(context).size.width * 0.85,
          curve: Curves.linear,
          duration: Duration(milliseconds: 700));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelTag("Bulk Orders"),
        Container(
          margin: EdgeInsets.only(top: 16.0),
          height: 350,
          child: Stack(
            children: [
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: productCategoryWidgetScrollController,
                  itemCount: this.catList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.width * 0.15,
                      child: ProductCategoryCard(
                        productCategory: catList[index],
                      ),
                    );
                  }),
              Positioned(
                  height: 100.0,
                  right: 0,
                  top: 125.0,
                  child: FlatButton(
                    onPressed: () {
                      productCategoryWidgetMoveRight();
                    },
                    child: NextListHover(),
                  )),
              Positioned(
                  height: 100.0,
                  left: 0,
                  top: 125.0,
                  child: FlatButton(
                    onPressed: () {
                      productCategoryWidgetMoveLeft();
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
