import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/widgets/wishlist_screen/add_to_cart_button.dart';
import '../../bloc/wishlist/wishlist_bloc.dart';

class WishlistProductItem extends StatelessWidget {
  final Wishlist product;
  final authID;

  const WishlistProductItem({
    Key key,
    this.product,
    this.authID = 'id1',
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: WishlistProductItemDetail(
        authID: authID,
        product: product,
      ),
    );
  }
}

class WishlistProductItemDetail extends StatelessWidget {
  final authID;
  final Wishlist product;

  const WishlistProductItemDetail({
    Key key,
    this.product,
    this.authID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.32,
      width: MediaQuery.of(context).size.width * 0.12,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/product', arguments: {
            "product": product,
          });
        },
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: MediaQuery.of(context).size.width * 0.12,
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<WishlistBloc>(context)
                            .add(DeleteWishlist(
                          authID: authID,
                          key: product.key,
                          productID: product.productID,
                        ));
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white.withAlpha(200),
                        radius: 17,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                  // TODO: Add to cart button
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: AddToCartButton(
                      productID: product.productID,
                      variantID: product.variantID,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                  bottom: 2.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.12,
                      height: 20,
                      child: RichText(
                        text: TextSpan(
                          text: product.name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        overflow: TextOverflow.ellipsis,
                        strutStyle: StrutStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 4),
                            child: Text(
                              Strings.rupeesSymbol +
                                  product.discountPrice.toString(),
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              right: 4,
                            ),
                            child: Text(
                              Strings.rupeesSymbol +
                                  product.sellingPrice.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          Text(
                            (((product.sellingPrice - product.discountPrice) /
                                            product.sellingPrice) *
                                        100)
                                    .toInt()
                                    .toString() +
                                '% Off',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
