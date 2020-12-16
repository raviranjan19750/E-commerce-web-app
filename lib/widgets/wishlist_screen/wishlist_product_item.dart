import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/wishlist/wishlist_bloc.dart';
import '../widgets.dart';

class WishlistProductItem extends StatelessWidget {
  final Wishlist product;

  const WishlistProductItem({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        width: MediaQuery.of(context).size.width * 0.15,
        child: Card(
          elevation: 2,
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.32,
                    width: MediaQuery.of(context).size.width * 0.15,
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
                          authID: "id1",
                          key: product.key,
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
                  // Positioned(
                  //   left: 0,
                  //   right: 0,
                  //   bottom: 0,
                  //   child: AddToCartButton(
                  //     productID: product.productID,
                  //     variantID: product.variantID,
                  //   ),
                  // )
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
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: 20,

                      // child: Text(
                      //   product.name,
                      //   overflow: TextOverflow.,
                      // ),
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
