import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/all_product/all_product_bloc.dart';
import 'dart:math' as math;

import 'package:living_desire/screens/all_product/product_widgets.dart';

class AllProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
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
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard()
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: BlocBuilder<AllProductBloc, AllProductState>(
                        builder: (context, state) {
                          if (state is LoadingAllProduct) {
                            return CircularProgressIndicator();
                          } else if (state is SuccessLoadingAllProduct) {

                            if (state.productList.isEmpty) {
                              return Center(
                                child: Text("No Product To Display"),
                              );
                            }

                            return Container(
                              padding: EdgeInsets.all(10),
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 20,
                                children: state.productList.map((e) => ProductCard(product: e)).toList(),
                              ),
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
