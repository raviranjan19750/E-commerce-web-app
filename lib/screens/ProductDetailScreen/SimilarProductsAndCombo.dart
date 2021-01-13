import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/similarProducts/similar_products_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/widgets/home_widget/view_all_card.dart';
import 'package:living_desire/widgets/labeltag/label_tag.dart';
import 'package:living_desire/widgets/nextListHover.dart';

class SimilarProductAndCombos extends StatelessWidget {
  List<String> type;
  List<String> subType;

  SimilarProductAndCombos({Key key, this.type, this.subType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double productListItemHeight =
        MediaQuery.of(context).size.height * 0.4;
    final double itemCardHeight = MediaQuery.of(context).size.height * 0.20;

    ScrollController similarProductScrollController = new ScrollController();
    ScrollController comboProductScrollController = new ScrollController();

    similarProductMoveRight() {
      similarProductScrollController.animateTo(
          similarProductScrollController.offset +
              MediaQuery.of(context).size.width * 0.85,
          curve: Curves.linear,
          duration: Duration(milliseconds: 700));
    }

    similarProductMoveLeft() {
      similarProductScrollController.animateTo(
          similarProductScrollController.offset -
              MediaQuery.of(context).size.width * 0.85,
          curve: Curves.linear,
          duration: Duration(milliseconds: 700));
    }

    comboProductMoveRight() {
      comboProductScrollController.animateTo(
          comboProductScrollController.offset +
              MediaQuery.of(context).size.width * 0.85,
          curve: Curves.linear,
          duration: Duration(milliseconds: 700));
    }

    comboProductMoveLeft() {
      comboProductScrollController.animateTo(
          comboProductScrollController.offset -
              MediaQuery.of(context).size.width * 0.85,
          curve: Curves.linear,
          duration: Duration(milliseconds: 700));
    }

    return BlocProvider(
      create: (context) =>
          SimilarProductsBloc(searchApi: RepositoryProvider.of(context))
            ..add(
              LoadingSimilarProducts(type, subType),
            ),
      child: BlocBuilder<SimilarProductsBloc, SimilarProductsState>(
          builder: (context, state) {
        if (state is SimilarProductsLoading) {
          return LinearProgressIndicator();
        } else if (state is SimilarProductsLoadingSuccessful) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 32.0, left: 32.0, right: 64.0),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: LabelTag(
                    Strings.similarProudcts,
                  )),
              Container(
                  margin: EdgeInsets.only(top: 16.0, left: 32.0, right: 64.0),
                  height: productListItemHeight,
                  child: Stack(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        controller: similarProductScrollController,
                        itemCount: state.product.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == state.product.length) {
                            return Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                child: ViewAllCard(
                                  routeString: subType[0],
                                ));
                          }

                          return Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.15,
                              padding: EdgeInsets.only(right: 8.0),
                              child:
                                  ProductCard(product: state.product[index]));
                        },
                      ),
                      Positioned(
                        right: 0,
                        top: itemCardHeight / 1.5,
                        child: FlatButton(
                            onPressed: similarProductMoveRight,
                            child: NextListHover()),
                      ),
                      Positioned(
                        left: 0,
                        top: itemCardHeight / 1.5,
                        child: FlatButton(
                            onPressed: similarProductMoveLeft,
                            child: NextListHover(
                              icon: Icons.arrow_back_ios,
                            )),
                      ),
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 32.0, left: 32.0, right: 64.0),
                child: Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
              ),
              Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: LabelTag(
                    Strings.Combos,
                  )),
              Container(
                  margin: EdgeInsets.only(top: 16.0, left: 32.0, right: 64.0),
                  height: productListItemHeight,
                  child: Stack(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        controller: comboProductScrollController,
                        itemCount: state.comboProduct.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == state.comboProduct.length) {
                            return Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                width: MediaQuery.of(context).size.width * 0.15,
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                child: ViewAllCard(
                                  routeString: subType[0],
                                ));
                          }

                          return Container(
                              width: MediaQuery.of(context).size.width * 0.15,
                              height: MediaQuery.of(context).size.height * 0.15,
                              padding: EdgeInsets.only(right: 8.0),
                              child: ComboProductCard(
                                comboProduct: state.comboProduct[index],
                              ));
                        },
                      ),
                      Positioned(
                        right: 0,
                        top: itemCardHeight / 1.5,
                        child: FlatButton(
                            onPressed: comboProductMoveRight,
                            child: NextListHover()),
                      ),
                      Positioned(
                        left: 0,
                        top: itemCardHeight / 1.5,
                        child: FlatButton(
                            onPressed: comboProductMoveLeft,
                            child: NextListHover(
                              icon: Icons.arrow_back_ios,
                            )),
                      ),
                    ],
                  )),
            ],
          );
        } else {
          return Center(child: Text("OOPS Something went wrong"));
        }
      }),
    );
  }
}
