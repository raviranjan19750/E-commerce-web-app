import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/all_product/all_product_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/filter/filter_bloc.dart';
import 'package:living_desire/bloc/product_card/product_card_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/comboProduct.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/models/sorting_criteria.dart';
import 'package:living_desire/screens/login/login_view.dart';
import 'package:living_desire/service/navigation_service.dart';

import '../../main.dart';
import '../../routes.dart';

import 'dart:js' as js;

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCardBloc(
          customerRepo: RepositoryProvider.of(context),
          wishlistBloc: BlocProvider.of(context),
          cartConfigBloc: BlocProvider.of(context),
          product: product,
          auth: BlocProvider.of(context)),
      child: Card(
          elevation: 5,
          child: ProductCardContent(
            product: product,
          )),
    );
  }
}

class ProductCardContent extends StatelessWidget {
  final Product product;

  const ProductCardContent({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double discount = 0;
    discount = (product.retailPrice - product.discountPrice) /
        product.retailPrice *
        100;

    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>().navigateTo(
                      RoutesConfiguration.PRODUCT_DETAIL,
                      queryParams: {
                        "pid": product.productId,
                        "vid": product.varientId,
                      },
                    );
                  },
                  child: Image.network(
                    product.imageUrls[0],
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: ProductWishlistButton(
                  productId: product.productId,
                  varientId: product.varientId,
                ),
              ),
              Positioned(
                bottom: 0,
                child: _AddToCartButton(
                    productId: product.productId, variantId: product.varientId),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    "₹" + product.discountPrice.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "₹" + product.retailPrice.toString(),
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (discount > 0)
                    Text(
                      discount.toStringAsPrecision(2) + "% Off",
                      style: TextStyle(color: Colors.green),
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class ComboProductCard extends StatelessWidget {
  final ComboProduct comboProduct;

  const ComboProductCard({Key key, this.comboProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCardBloc(
          customerRepo: RepositoryProvider.of(context),
          wishlistBloc: BlocProvider.of(context),
          cartConfigBloc: BlocProvider.of(context),
          comboProduct: comboProduct,
          auth: BlocProvider.of(context)),
      child: Card(
          elevation: 5.0,
          child: ComboProductCardContent(
            comboProduct: comboProduct,
          )),
    );
  }
}

class ComboProductCardContent extends StatelessWidget {
  final ComboProduct comboProduct;

  const ComboProductCardContent({Key key, this.comboProduct}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double discount = 0;
    discount = (comboProduct.retailPrice - comboProduct.discountPrice) /
        comboProduct.retailPrice *
        100;

    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>().navigateTo(
                      RoutesConfiguration.PRODUCT_DETAIL,
                      queryParams: {
                        "pid": comboProduct.productId,
                        "vid": comboProduct.productId,
                      },
                    );
                    // Navigator.pushNamed(
                    //     context, path,
                    //     arguments: {
                    //       "product": product,
                    //       "productID": product.productId,
                    //       "variantID": product.varientId
                    //     });
                  },
                  child: Image.network(
                    comboProduct.imageUrls[0],
                    fit: BoxFit.cover,
                  ),
                ),
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: ProductWishlistButton(
                  productId: comboProduct.productId,
                  varientId: comboProduct.productId,
                ),
              ),
              Positioned(
                bottom: 0,
                child: _AddToCartButton(),
              )
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comboProduct.title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 2,
              ),
              Row(
                children: [
                  Text(
                    "₹" + comboProduct.discountPrice.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "₹" + comboProduct.retailPrice.toString(),
                    style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (discount > 0)
                    Text(
                      discount.toStringAsPrecision(2) + "% Off",
                      style: TextStyle(color: Colors.green),
                    )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class FilterCard extends StatefulWidget {
  final FilterTag filters;
  final int maxFiltersToShow;

  const FilterCard({Key key, this.filters, this.maxFiltersToShow = 5})
      : super(key: key);

  @override
  _FilterCardState createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  bool isLongerList;

  @override
  void initState() {
    super.initState();
    isLongerList = widget.filters.filterChilds.length > widget.maxFiltersToShow;
  }

  Widget _buildFilters() {
    if (isLongerList) {
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    List<FilterCategoryChild> childs;

    if (isLongerList) {
      childs = widget.filters.filterChilds.sublist(0, widget.maxFiltersToShow);
    } else {
      childs = widget.filters.filterChilds;
    }

    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(width: 1, color: Colors.grey))),
      padding: EdgeInsets.only(left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Text(
            widget.filters.description,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          ...childs.map((e) => FilterCheckBox(
                onChanged: (val) => {
                  BlocProvider.of<FilterBloc>(context)
                      .add(ChangeFilterEvent(widget.filters.tag, e, val))
                },
                filterLabel: e,
              )),
          if (isLongerList)
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "+" +
                        (widget.filters.filterChilds.length -
                                widget.maxFiltersToShow)
                            .toString() +
                        " More",
                    style: TextStyle(color: Colors.red),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isLongerList = false;
                        });
                      })
              ]),
            ),
          if (!isLongerList &&
              widget.filters.filterChilds.length > widget.maxFiltersToShow)
            RichText(
              text: TextSpan(children: [
                TextSpan(
                    text: "Hide Results",
                    style: TextStyle(color: Colors.red),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        setState(() {
                          isLongerList = true;
                        });
                      })
              ]),
            ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

class FilterCheckBox extends StatelessWidget {
  final ValueChanged<bool> onChanged;
  final FilterCategoryChild filterLabel;

  const FilterCheckBox({Key key, this.onChanged, this.filterLabel})
      : assert(filterLabel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Container(
            constraints: BoxConstraints.tight(Size(8, 8)),
            child: Checkbox(
              value: filterLabel.selected,
              onChanged: onChanged,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            filterLabel.description,
            style: TextStyle(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}

class ProductWishlistButton extends StatefulWidget {
  final String productId;
  final String varientId;
  // final Product product;

  const ProductWishlistButton({Key key, this.productId, this.varientId})
      : super(key: key);

  @override
  _ProductWishlistButtonState createState() =>
      _ProductWishlistButtonState(productId, varientId);
}

class _ProductWishlistButtonState extends State<ProductWishlistButton> {
  bool _wishHover;
  // final Product product;
  final String p_id;
  final String v_id;

  // Box<String> wishlist = Hive.box('wishlist_items');
  // final _wishlist = Hive.box<Map<String, String>>('wishlist_items');

  _ProductWishlistButtonState(this.p_id, this.v_id);

  @override
  void initState() {
    super.initState();
    // _wishHover;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCardBloc, ProductCardState>(
        builder: (context, state) {
      if (_wishHover == null) {
        _wishHover = state.isItemInWishList;
      }
      return Container(
        padding: EdgeInsets.all(6.0),
        child: MouseRegion(
            onEnter: (event) {
              if (!state.isItemInWishList) {
                setState(() {
                  _wishHover = !state.isItemInWishList;
                });
              }
            },
            onExit: (event) {
              if (!state.isItemInWishList) {
                setState(() {
                  _wishHover = state.isItemInWishList;
                });
              }
            },
            child: _wishHover
                ? GestureDetector(
                    onTap: () {
                      // wishlist.add(product.toJson().toString());
                      // _wishlist.put(product.varientId, product);
                      // _wishlist
                      //     .put(p_id, {"productID": p_id, "variantID": v_id});
                      BlocProvider.of<ProductCardBloc>(context)
                          .add(AddToWishListProductEvent());
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withAlpha(200),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      // wishlist.delete();
                      // _wishlist.delete(v_id);
                      BlocProvider.of<ProductCardBloc>(context)
                          .add(RemoveFromWishListProductEvent());
                    },
                    child: CircleAvatar(
                      radius: 17.0,
                      backgroundColor: Colors.white.withAlpha(200),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red,
                      ),
                    ))
            // : CircleAvatar(
            //     radius: 17.0,
            //     backgroundColor: Colors.white.withAlpha(200),
            //     child: Icon(
            //       Icons.favorite_border_outlined,
            //       color: Colors.red,
            //     ),
            //   ),
            ),
      );
    });
  }
}

class FilterDropDown extends StatefulWidget {
  @override
  _FilterDropDownState createState() => _FilterDropDownState();
}

class _FilterDropDownState extends State<FilterDropDown> {
  FilterSortCriteria _value = FilterSortCriteria.RELEVANCE;

  @override
  Widget build(BuildContext context) {
    _value = BlocProvider.of<AllProductBloc>(context).sortCriteria;
    return Container(
      padding: EdgeInsets.only(left: 10, top: 3, right: 3, bottom: 3),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.grey, style: BorderStyle.solid, width: 1.0),
          borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        children: [
          Text("Sort By  "),
          DropdownButtonHideUnderline(
            child: DropdownButton(
                isDense: true,
                value: _value,
                items: [
                  DropdownMenuItem(
                    child: Text("Relevance"),
                    value: FilterSortCriteria.RELEVANCE,
                  ),
                  DropdownMenuItem(
                    child: Text("Price: Low To High"),
                    value: FilterSortCriteria.PRICE_LOW_TO_HIGH,
                  ),
                  DropdownMenuItem(
                    child: Text("Price: High To Low"),
                    value: FilterSortCriteria.PRICE_HIGH_TO_LOW,
                  ),
                  DropdownMenuItem(
                    child: Text("Newest Arrival"),
                    value: FilterSortCriteria.NEWEST_FIRST,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    _value = value;
                    BlocProvider.of<AllProductBloc>(context)
                        .add(LoadAllProductWithSearchParams(sort: _value));
                  });
                }),
          ),
        ],
      ),
    );
  }
}

class _AddToCartButton extends StatefulWidget {
  final String productId;
  final String variantId;

  const _AddToCartButton({Key key, this.productId, this.variantId})
      : super(key: key);

  @override
  __AddToCartButtonState createState() => __AddToCartButtonState();
}

class __AddToCartButtonState extends State<_AddToCartButton> {
  bool _visible;

  void _showLoginDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoginScreen();
        });
  }

  Widget _buildWidget(bool _on, BuildContext context) {
    if (_on) {
      return InkWell(
        onTap: () {
          if (BlocProvider.of<AuthenticationBloc>(context).state.user?.uid !=
              null) {
            BlocProvider.of<ProductCardBloc>(context).add(AddToCartEvent());
          } else {
            _showLoginDialog(context);
          }
        },
        child: AnimatedContainer(
          width: 400,
          color: Colors.white.withAlpha(180),
          duration: Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 6),
          child: Icon(Icons.add_shopping_cart),
        ),
      );
    } else {
      return Container(width: 400, height: 35, margin: EdgeInsets.all(0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCardBloc, ProductCardState>(
        builder: (context, state) {
      if (_visible == null) {
        _visible = state.isItemInCart;
      }

      if (state.isItemInCart) {
        return InkWell(
          onTap: () {
            locator<NavigationService>().navigateTo(RoutesConfiguration.CART);
          },
          child: AnimatedContainer(
            width: 400,
            color: Colors.white.withAlpha(180),
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text(Strings.goToCart),
          ),
        );
      }

      return Container(
        child: MouseRegion(
            onEnter: (event) {
              if (!state.isItemInCart) {
                setState(() {
                  _visible = true;
                });
              }
            },
            onExit: (event) {
              if (!state.isItemInCart) {
                setState(() {
                  _visible = false;
                });
              }
            },
            child: _buildWidget(_visible, context)),
      );
    });
  }
}
