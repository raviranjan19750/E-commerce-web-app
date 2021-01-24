import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_card/product_card_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/comboProduct.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductAvailablity.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailEnlargeImage.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/ProductCountWidget.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/customButtonWidgets.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/productVariantColorList.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/productVariantSizeList.dart';
import 'package:living_desire/widgets/bullet.dart';

import '../../main.dart';
import 'SimilarProductsAndCombo.dart';

class ProductDetailDescriptionAndImage extends StatefulWidget {
  String authID;

  ProductDetailDescriptionAndImage({Key key, this.authID}) : super(key: key);

  @override
  _ProductDetailDescriptionAndImageState createState() =>
      _ProductDetailDescriptionAndImageState();
}

class _ProductDetailDescriptionAndImageState
    extends State<ProductDetailDescriptionAndImage> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    List<String> comboVariantType = new List();
    List<String> comboVariantSubType = new List();
    List<String> variantType = new List();
    List<String> variantSubType = new List();

    List<String> getComboType(List<Variant> variant) {
      for (var typ in variant) {
        comboVariantType.add(typ.type);
      }

      return comboVariantType.toSet().toList();
    }

    List<String> getComboSubType(List<Variant> variant) {
      for (var subTyp in variant) {
        comboVariantSubType.add(subTyp.subType);
      }

      return comboVariantSubType.toSet().toList();
    }

    List<String> getType(String type) {
      variantType.add(type);

      return variantType.toSet().toList();
    }

    List<String> getSubType(String subType) {
      variantSubType.add(subType);

      return variantSubType.toSet().toList();
    }

    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
// ignore: missing_return
        builder: (context, state) {
      if (state is ProductDetailLoading) {
        return LinearProgressIndicator();
      } else if (state is ProductDetailLoadingSuccessful) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCardBloc(
              productDetail: state.productDetail,
              customerRepo: RepositoryProvider.of(context),
                cartConfigBloc: BlocProvider.of(context),
              wishlistBloc: BlocProvider.of(context),
              auth: BlocProvider.of(context)
            ))
          ],
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // list of images
                  ProductDetailEnlargeImage(
                    imageURL: state.productDetail.images,
                    productID: state.productDetail.productID,
                    variantID: state.productDetail.variantID,
                    isInCart: state.productDetail.isInCart,
                    itemCount: itemCount,
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
                          margin: EdgeInsets.only(top: 12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              (state.productDetail.isAvailable)
                                  ? ProductAvailability(
                                      productID: state.productDetail.productID,
                                      variantID: state.productDetail.variantID,
                                    )
                                  : Container(
                                      height: 0,
                                    ),
//list of color

                              Container(
//width: 150,
                              height: 25,
                              margin: EdgeInsets.only(top: 32.0),
                              child: ProductVariantColorWidget(
                                colorList: state.productDetail.colourOptions,
                                initialSelectedColor: state.productDetail.colour,
                                productID: state.productDetail.productID,
                                productAllVariant: state.productDetail.allVariants,
                                size: state.productDetail.size,
                                authID: widget.authID,
                              ),
                            ),

                              Container(
                                height: 45,
                                margin: EdgeInsets.only(top: 16.0),
                                child: ProductVariantSizeList(
                                  sizeOptionsList:
                                  state.productDetail.sizeOptions,
                                  productID: state.productDetail.productID,
                                  variantSize: state.productDetail.size,
                                  selectedColor: state.productDetail.colour,
                                  allVariantList: state.productDetail.allVariants,
                                  type: state.productDetail.type,
                                  subType: state.productDetail.subType,
                                ),
                              ),

// setting size and quantity button
                              Container(
                                margin: EdgeInsets.only(top: 12.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          )),
                                      child: Row(
                                        children: [
                                          ProductQuantityCount(
                                            onItemCountChanged: (val) {
                                              setState(() {
                                                itemCount = val;
                                              });
                                            },
                                          ),
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
                                        onPressed: () {
                                          locator<NavigationService>().navigateTo(
                                              RoutesConfiguration.BULK_ORDER,
                                              queryParams: {
                                                "productID":
                                                    state.productDetail.productID,
                                                "variantID":
                                                    state.productDetail.variantID,
                                                "productType":
                                                    state.productDetail.type,
                                                "productSubType":
                                                    state.productDetail.subType,
                                                "size": state.productDetail.size,
                                                "color":'#${state.productDetail.colour.first.colorHexCode.value.toRadixString(16)}',
                                              });
                                        },
                                        text: Strings.customizeWithLogo,
                                      ),
                                    )
                                  : Container(),

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
              SimilarProductAndCombos(
                  type: getType(state.productDetail.type),
                  subType: getSubType(state.productDetail.subType)),
              Container(
                height: 100,
              ),
            ],
          ),
        );
      } else if (state is ComboProductDetailLoadingSuccessful) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => ProductCardBloc(
                comboProduct: state.comboProduct,
                customerRepo: RepositoryProvider.of(context),
                cartConfigBloc: BlocProvider.of(context),
                wishlistBloc: BlocProvider.of(context),
                auth: BlocProvider.of(context)
            ))
          ],
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // list of images
                  ProductDetailEnlargeImage(
                    imageURL: state.comboProduct.imageUrls,
                    productID: state.comboProduct.productId,
                    variantID: state.comboProduct.productId,
                    isInCart: state.comboProduct.isInCart,
                    itemCount: itemCount,
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
                            state.comboProduct.title,
                            style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16.0),
                          child: Text(
                            "₹ " + state.comboProduct.retailPrice.toString(),
                            style: TextStyle(
                                color: Colors.grey[400],
                                decoration: TextDecoration.lineThrough,
                                fontSize: 14),
                          ),
                        ),
                        Container(
                          child: Text(
                            "₹ " + state.comboProduct.discountPrice.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 22),
                          ),
                        ),
                        Container(
                          child: (state.comboProduct.isAvailable)
                              ? Text(
                                  "You save ₹ " +
                                      (state.comboProduct.retailPrice -
                                              state.comboProduct.discountPrice)
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
                              (state.comboProduct.isAvailable)
                                  ? ProductAvailability(
                                      productID: state.comboProduct.productId,
                                    )
                                  : Container(
                                      height: 100,
                                    ),

//  quantity button
                              Container(
                                margin: EdgeInsets.only(top: 8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 0.5,
                                          )),
                                      child: Row(
                                        children: [
                                          ProductQuantityCount(
                                            onItemCountChanged: (val) {
                                              setState(() {
                                                itemCount = val;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                                  children: state.comboProduct.descriptions
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
              SimilarProductAndCombos(
                  type: getComboType(state.comboProduct.productVariant),
                  subType: getComboSubType(state.comboProduct.productVariant)),
              Container(
                height: 100,
              ),
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }
}
