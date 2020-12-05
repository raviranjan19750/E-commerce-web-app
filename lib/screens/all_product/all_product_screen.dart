import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/all_product/all_product_bloc.dart';
import 'package:living_desire/bloc/filter/filter_bloc.dart';
import 'dart:math' as math;

import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:shimmer/shimmer.dart';

class AllProductScreen extends StatelessWidget {
  final scrollPhysics = ScrollPhysics();
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AllProductBloc>(context).add(InitializeLoadingProduct());
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          physics: scrollPhysics,
          controller: scrollController,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Filters",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    FilterDropDown()
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(width: 1.0, color: Colors.grey),
                            // top: BorderSide(width: 1.0, color: Colors.grey),
                          ),
                        ),
                        child: BlocBuilder<FilterBloc, FilterState>(
                            builder: (context, state) {
                          return Column(
                            children: state.filters
                                .map((e) => FilterCard(filters: e))
                                .toList(),
                          );
                        }),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: BlocBuilder<AllProductBloc, AllProductState>(
                        builder: (context, state) {
                          if (state is LoadingAllProduct) {
                            return Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.only(top: 30, left: 30),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 1, color: Colors.grey))),
                                child: Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children: [
                                    LoadingCard(),
                                    LoadingCard(),
                                    LoadingCard(),
                                    LoadingCard(),
                                    LoadingCard(),
                                    LoadingCard(),
                                    LoadingCard()
                                  ],
                                ));
                          } else if (state is SuccessLoadingAllProduct) {
                            scrollController.addListener(() {
                              if (scrollController.position.atEdge) {
                                if (scrollController.position.pixels != 0) {
                                  print("loading more product");
                                  BlocProvider.of<AllProductBloc>(context)
                                      .add(LoadNextProduct());
                                }
                              }
                            });

                            if (state.productList.isEmpty) {
                              return Center(
                                child: Text("No Product To Display"),
                              );
                            }

                            var size = MediaQuery.of(context).size;
                            final double itemHeight = (size.height) / 2;
                            final double itemWidth = size.width / 2;

                            return Container(
                                margin: EdgeInsets.all(0),
                                padding: EdgeInsets.only(top: 30, left: 30),
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 1, color: Colors.grey))),
                                child: GridView.count(
                                  childAspectRatio: 0.7,
                                   primary: true,
                                   shrinkWrap: true,
                                    crossAxisCount: 4,
                                  children: state.productList
                                        .map((e) => ProductCard(product: e))
                                        .toList(),
                                ),

                                // Wrap(
                                //   alignment: WrapAlignment.spaceBetween,
                                //   children: state.productList
                                //       .map((e) => ProductCard(product: e))
                                //       .toList(),
                                // ),
                            );
                          }
                          return Container();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator();
  }
}
