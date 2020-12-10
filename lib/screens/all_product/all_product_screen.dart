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

  const AllProductScreen({Key key, this.searchFilter}) : super(key: key);

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
          shrinkWrap: true,
          primary: true,
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
            BuildAllProductView(),
          ],
        ),
      ),
    );
  }
}

class AllProductScreenBuilder extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      // appBar: CustomAppBar(
      //   size: 120,
      // ),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return [];
      },
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.85,
          ),
          child: ListView(
            controller: PrimaryScrollController.of(context),
            shrinkWrap: true,
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
                    child: BuildAllProductView(),
                  )
                ],
              ),
              Footer()
            ],
          ),
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
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductBloc, AllProductState>(
      builder: (context, state) {
        if (state is LoadingAllProduct) {
          return ProductLoadingView();
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
                border: Border(
                    top: BorderSide(
                        width: 1, color: Colors.grey))),
            child: ListView.builder(
              controller: PrimaryScrollController.of(context),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: state.productList.length,
              itemBuilder: (_, index) => ProductCard(product: state.productList[index]),
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
