import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailDescriptionsAndImage.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productID;
  final String variantID;

  const ProductDetailScreen({
    Key key,
    this.productID,
    this.variantID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Loading Product Detail");
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) =>
            ProductDetailBloc(productRepository: RepositoryProvider.of(context))
              ..add(LoadProductDetail(
                productID,
                variantID,
              )),
      ),
      BlocProvider(
          create: (context) =>
              CartBloc(cartRepository: RepositoryProvider.of(context))),
    ], child: ProductDetail());
  }
}

class ProductDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.only(top: 32.0),

          child: ProductDetailDescriptionAndImage(),
        ),
      ],
    );
  }
}
