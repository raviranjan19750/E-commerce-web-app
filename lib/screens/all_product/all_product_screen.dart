import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/all_product/all_product_bloc.dart';
import 'package:living_desire/bloc/filter/filter_bloc.dart';
import 'package:living_desire/bloc/scroll/bloc/scroll_bloc.dart';
import 'package:living_desire/models/product.dart';

import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/screens/home_screen/home_screen_desktop.dart';

class AllProductScreen extends StatelessWidget {
  final String searchFilter;

  AllProductScreen({Key key, this.searchFilter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllProductEvent event;
    if (searchFilter != null && searchFilter.isNotEmpty) {
      event = LoadAllProductWithSearchParams(filterText: searchFilter);
    } else {
      event = InitializeLoadingProduct();
    }

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  FilterBloc(searchApi: RepositoryProvider.of(context))
                    ..add(InitializeDummyFilter())),
          BlocProvider(
              create: (context) =>
                  AllProductBloc(searchApi: RepositoryProvider.of(context))
                    ..add(event))
        ],
        child: MyDesktopView(
          child: ListView(
            shrinkWrap: true,
            primary: false,
            // primary: true,
            children: [
              SizedBox(
                height: 30,
              ),
              BlocBuilder<AllProductBloc, AllProductState>(
                  buildWhen: (prev, current) {
                if (current is SuccessLoadingAllProduct) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                if (state is SuccessLoadingAllProduct)
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filters (" + state.totalResults.toString() + ")",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          FilterDropDown()
                        ],
                      ),
                    ),
                  );
                else
                  return Container();
              }),
              AllProductScreenBuilder(),
              BlocBuilder<AllProductBloc, AllProductState>(builder: (_, state) {
                if (state is LoadingNextProduct) {
                  return Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.85,
                      ),
                      child: LinearProgressIndicator());
                } else if (state is AllProductLoaded) {
                  return Container(
                    margin: EdgeInsets.all(20),
                    child: Center(
                      child: Text("No More Product To Display"),
                    ),
                  );
                }
                return Container();
              }),
            ],
          ),
        ));
  }
}

class AllProductScreenBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.85,
        ),
        child: Row(
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
              child: BuildAllProductView(),
            )
          ],
        ),
      ),
    );
  }
}

class LoadFilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ProductLoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(0),
        padding: EdgeInsets.only(top: 30, left: 30),
        decoration: BoxDecoration(
            border: Border(top: BorderSide(width: 1, color: Colors.grey))),
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
  }
}

class SuccessfullyLoadedProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BuildAllProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context1) {
    return BlocBuilder<AllProductBloc, AllProductState>(
      buildWhen: (prev, current) {
        if (current is LoadingNextProduct) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        if (state is LoadingAllProduct) {
          return ProductLoadingView();
        } else if (state is SuccessLoadingAllProduct) {
          if (state.productList.isEmpty) {
            return Center(
              child: Text("No Product To Display"),
            );
          }

          BlocProvider.of<ScrollBloc>(context).controller.addListener(() {
            if (BlocProvider.of<ScrollBloc>(context)
                        .controller
                        .position
                        .extentAfter < 300 &&
                !state.isEndReached) {
              BlocProvider.of<AllProductBloc>(context).add(LoadNextProduct());
            }
          });

          return Container(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.only(top: 30, left: 30),
              decoration: BoxDecoration(
                  border:
                      Border(top: BorderSide(width: 1, color: Colors.grey))),
              child: AllProductGrid(
                products: state.productList,
              ));
        }
        return Container();
      },
    );
  }
}

class AllProductGrid extends StatelessWidget {
  final List<Product> products;

  AllProductGrid({Key key, this.products})
      : assert(products != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int itemCount = 4;
    if (width < 1000) {
      itemCount = 2;
    } else if (width < 1200) {
      itemCount = 3;
    }
    // 1200 - 3
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: itemCount,
        childAspectRatio: 0.73,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8
      ),
      itemCount: products.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class LoadingCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator();
  }
}
