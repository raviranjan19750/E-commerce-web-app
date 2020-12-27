import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/product_card/product_card_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/bloc/similarProducts/similar_products_bloc.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/models/product_type.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailDescriptionsAndImage.dart';
import 'package:living_desire/screens/ProductDetailScreen/SimilarProductsAndCombo.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/home_screen_products/product_item.dart';
import 'package:living_desire/widgets/nextListHover.dart';
import 'package:living_desire/widgets/productTypeBar.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productID;
  final String variantID;
  final Product product;

  const ProductDetailScreen({
    Key key,
    this.productID,
    this.variantID,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ProductDetailBloc(productRepository: RepositoryProvider.of(context))..add(LoadProductDetail(productID, variantID,)),
      ),
      
      BlocProvider(create: (context) => CartBloc(cartRepository: RepositoryProvider.of(context))),
    ], child: ProductDetail(product: product,));
  }
}

class ProductDetail extends StatelessWidget {
   Product product;

   ProductDetail({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.only(top: 64.0),
          child: ProductDetailDescriptionAndImage(product: product,),
        ),

      ],
    );
  }
}
