import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/all_product/all_product_bloc.dart';
import 'package:living_desire/bloc/filter/filter_bloc.dart';

import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/footer/footer.dart';

class AllProductScreen extends StatelessWidget {
  final String searchFilter;

  AllProductScreen({Key key, this.searchFilter}) : super(key: key);

  final ScrollController _controller = ScrollController();

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
      child: Scaffold(
        appBar: CustomAppBar(
          size: 120,
        ),
        body: ListView(
          controller: _controller,
          shrinkWrap: true,
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
                          "Filters (" + state.totalResults.toString()+ ")",
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
            AllProductScreenBuilder(
              parentScrollController: _controller,
            ),
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
            Footer()
          ],
        ),
      ),
    );
  }
}

class AllProductScreenBuilder extends StatelessWidget {
  final ScrollController parentScrollController;

  const AllProductScreenBuilder({Key key, this.parentScrollController})
      : super(key: key);

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
              child: BuildAllProductView(
                parentController: parentScrollController,
              ),
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
  final ScrollController parentController;

  const BuildAllProductView({Key key, this.parentController}) : super(key: key);

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
        print(parentController.hasClients);
        print(parentController.hasListeners);
        parentController.notifyListeners();
        if (state is LoadingAllProduct) {
          return ProductLoadingView();
        } else if (state is SuccessLoadingAllProduct) {
          if (state.productList.isEmpty) {
            return Center(
              child: Text("No Product To Display"),
            );
          }

          parentController.addListener(() {
            if (parentController.position.extentAfter < 300 && !state.isEndReached) {
              BlocProvider.of<AllProductBloc>(context).add(LoadNextProduct());
            }
          });

          return Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.only(top: 30, left: 30),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1, color: Colors.grey))),
            child: Wrap(
              runSpacing: 5,
              spacing: 5,
              children: state.productList
                  .map((e) => ProductCard(product: e))
                  .toList(),
            ),
          );
        }
        return Container();
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
