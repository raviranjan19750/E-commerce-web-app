import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailDescriptionsAndImage.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productID;
  final String variantID;

  const ProductDetailScreen({Key key, this.productID, this.variantID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("Loading Product Detail");

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      switch (state.status) {
        case AuthenticationStatus.authenticated:
          return MultiBlocProvider(
              providers: [
                (productID == variantID)
                    ? BlocProvider(
                        create: (context) => ProductDetailBloc(
                            productRepository: RepositoryProvider.of(context))..add(LoadComboProductDetail(
                              productID: productID, authID: state.user.uid)),
                      )
                    : BlocProvider(
                        create: (context) => ProductDetailBloc(
                            productRepository: RepositoryProvider.of(context))
                          ..add(LoadProductDetail(
                              productID: productID,
                              variantID: variantID,
                              authID: state.user.uid)),
                      ),
                BlocProvider(
                    create: (context) => CartBloc(
                        cartRepository: RepositoryProvider.of(context))),
              ],
              child: ProductDetail(
                authID: state.user.uid,
              ));
        case AuthenticationStatus.unauthenticated:
          return MultiBlocProvider(providers: [
            (productID == variantID)
                ? BlocProvider(
                    create: (context) => ProductDetailBloc(
                        productRepository: RepositoryProvider.of(context))
                      ..add(LoadComboProductDetail(
                        productID: productID,
                      )),
                  )
                : BlocProvider(
                    create: (context) => ProductDetailBloc(
                        productRepository: RepositoryProvider.of(context))
                      ..add(LoadProductDetail(
                          productID: productID, variantID: variantID)),
                  ),
            BlocProvider(
                create: (context) =>
                    CartBloc(cartRepository: RepositoryProvider.of(context))),
          ], child: ProductDetail());
        default:
          return Container();
      }
    });
  }
}

class ProductDetail extends StatelessWidget {
  String authID;

  ProductDetail({Key key, this.authID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          margin: EdgeInsets.only(top: 32.0),
          child: ProductDetailDescriptionAndImage(
            authID: authID,
          ),
        ),
      ],
    );
  }
}
