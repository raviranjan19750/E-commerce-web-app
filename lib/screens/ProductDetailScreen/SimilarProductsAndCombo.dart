
import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/similarProducts/similar_products_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/models/product_type.dart';
import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/widgets/home_screen_products/product_item.dart';
import 'package:living_desire/widgets/labeltag/label_tag.dart';
import 'package:living_desire/widgets/nextListHover.dart';
import 'package:living_desire/widgets/productTypeBar.dart';

class SimilarProductAndCombos extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final String productType = "Bean Bags";
    final List<Color> itemColor = itemColors;
    final List<String> itemDescriptions = productItemDescriptions;
    final List<Product> products = product;
    final List<ProductType> productTypes = productsType;

    final double productListItemHeight = MediaQuery.of(context).size.height * 0.4;
    final double itemCardHeight = MediaQuery.of(context).size.height * 0.20;
    final double descriptionWidth = MediaQuery.of(context).size.width * 0.4;


    return BlocBuilder<SimilarProductsBloc,SimilarProductsState >(
        builder: (context, state) {

          if(state is SimilarProductsLoading) {
            return LinearProgressIndicator();
          }
          else if (state is SimilarProductsLoadingSuccessful) {
            return Column(

              children: [

                Container(
                  margin: EdgeInsets.only(top: 32.0, left: 32.0, right: 0.0),
                  child: LabelTag(
                   Strings.similarProudcts,
                  )
                ),

                Container(
                    margin: EdgeInsets.only(top: 16.0, left: 32.0, right: 64.0),
                    height: productListItemHeight,
                    child: Stack(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.product.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: MediaQuery.of(context).size.height * 0.15,
                                padding: EdgeInsets.only(right: 8.0),
                                child: ProductCard(product: state.product[index]));
                          },
                        ),
                        Positioned(
                          right: 0,
                          top: itemCardHeight / 2,
                          child: FlatButton(child: NextListHover()),
                        ),
                      ],
                    )),

                Container(
                  margin: EdgeInsets.only(top: 32.0, left: 32.0, right: 0.0),
                  child:LabelTag(
                  Strings.Combos,
                  )
                ),

                Container(
                    margin: EdgeInsets.only(top: 16.0, left: 32.0, right: 64.0),
                    height: productListItemHeight,
                    child: Stack(
                      children: [
                        ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: state.product.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width: MediaQuery.of(context).size.width * 0.15,
                                height: MediaQuery.of(context).size.height * 0.15,
                                padding: EdgeInsets.only(right: 8.0),
                                child: ProductCard(product: state.product[index]));
                          },
                        ),
                        Positioned(
                          right: 0,
                          top: itemCardHeight / 2,
                          child: NextListHover(),
                        ),
                      ],
                    )),

              ],
            );
          }
          else {
            return Center(child: Text("OOPS Something went wrong"));
          }
        }
    );
  }
}
