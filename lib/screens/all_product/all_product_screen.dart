import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/all_product/all_product_bloc.dart';
import 'package:living_desire/bloc/filter/filter_bloc.dart';
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
                              children: state.filters.map((e) => FilterCard(filters: e)).toList(),
                            );
                          }
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
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
                              margin: EdgeInsets.all(0),
                              padding: EdgeInsets.only(top: 30, left: 30),
                              decoration: BoxDecoration(
                                border: Border(top: BorderSide(width: 1, color: Colors.grey))
                              ),
                              child: Wrap(
                                spacing: 12,
                                runSpacing: 20,
                                children: state.productList
                                    .map((e) => ProductCard(product: e))
                                    .toList(),
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
