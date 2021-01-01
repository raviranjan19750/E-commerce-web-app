import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductAvailablity.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailEnlargeImage.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/ProductCountWidget.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/ProductSizeDropdownWidget.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/customButtonWidgets.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/productVariantColorList.dart';
import 'package:living_desire/widgets/bullet.dart';

import 'SimilarProductsAndCombo.dart';

class ProductDetailDescriptionAndImage extends StatelessWidget {
  final List<Color> itemColor;
  final List<String> itemDescriptions;

  ProductDetailDescriptionAndImage(
      {Key key,
      this.itemColor = itemColors,
      this.itemDescriptions = productItemDescriptions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
// ignore: missing_return
        builder: (context, state) {
      if (state is ProductDetailLoading) {
        return LinearProgressIndicator();
      } else if (state is ProductDetailLoadingSuccessful) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // list of images
                ProductDetailEnlargeImage(
                  imageURL: state.productDetail.images,
                  productID: state.productDetail.productID,
                  variantID: state.productDetail.variantID,

                ),

                // description of product
                Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          state.productDetail.productName,
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: Text(
                          "₹ " + state.productDetail.sellingPrice.toString(),
                          style: TextStyle(
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        child: Text(
                          "₹ " + state.productDetail.discountPrice.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      ),
                      Container(
                        child: (state.productDetail.isAvailable)
                            ? Text(
                                "You save ₹ " +
                                    (state.productDetail.sellingPrice -
                                            state.productDetail.discountPrice)
                                        .toString(),
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              )
                            : Text(
                                Strings.outOfStock,
                                style: TextStyle(
                                    color: Colors.red[500],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (state.productDetail.isAvailable)
                                ? ProductAvailability(
                                    productID: state.productDetail.productID,
                                    variantID: state.productDetail.variantID,
                                  )
                                : Container(),
//list of color
//todo Set lst of color

                            Container(
//width: 150,
                              height: 50,
                              margin: EdgeInsets.only(top: 16.0),
                              child: ProductVariantColorWidget(
                                colorList: state.productDetail.colourOptions,
                                initialSelectedColor:
                                    state.productDetail.colour,
                                productID: state.productDetail.productID,
                                productAllVariant:
                                    state.productDetail.allVariants,
                                size: state.productDetail.size,
                              ),
                            ),

// setting size and quantity button
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
//dropdown menu for sizes
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    height: 40,
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: Text(
                                            Strings.size + ": ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),
                                        ProductSizeDropdown(
                                          productSizeList:
                                              state.productDetail.sizeOptions,
                                          productID:
                                              state.productDetail.productID,
                                          productSize: state.productDetail.size,
                                          initialSelectedColor:
                                              state.productDetail.colour,
                                          productAllVariant:
                                              state.productDetail.allVariants,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 12),

                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    child: Row(
                                      children: [
                                        ProductQuantityCount(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

//customize logo button
                            state.productDetail.isCustomizable
                                ? Container(
                                    height: 45,
                                    width: 220,
                                    margin: EdgeInsets.only(top: 12.0),
                                    child: CustomWidgetButton(
                                      onPressed: () {},
                                      text: Strings.customizeWithLogo,
                                    ),
                                  )
                                : Container(
                                    height: 45,
                                    width: 220,
                                    color: Colors.brown,
                                    margin: EdgeInsets.only(top: 12.0),
                                    child: CustomWidgetButton(
                                      onPressed: () {},
                                      text: Strings.customizeWithLogo,
                                    ),
                                  ),

                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                Strings.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22),
                              ),
                            ),

                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width * 0.4,
                              margin: EdgeInsets.only(top: 8.0),
                              child: Column(
                                children: state.productDetail.description
                                    .map((e) => Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Bullets(),
                                            Container(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: Text(
                                                e,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SimilarProductAndCombos(type: "Bean Bag", subType: "Sofa"),
            Container(
              height: 100,
            ),
          ],
        );
      } else {
        return Container();
      }
    });
  }
}
