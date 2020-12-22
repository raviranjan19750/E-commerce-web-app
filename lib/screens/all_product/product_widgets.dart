import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/filter/filter_bloc.dart';
import 'package:living_desire/bloc/product_card/product_card_bloc.dart';
import 'package:living_desire/models/models.dart';

import '../../routes.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCardBloc(
        customerRepo: RepositoryProvider.of(context),
        wishlistBloc: BlocProvider.of(context),
        product: product,
      ),
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
                    Navigator.pushNamed(context, RoutesConfiguration.PRODUCT_DETAIL,
                        arguments: {"product": product, "productID": product.productId, "variantID": product.varientId});
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
                child: ProductWishlistButton(productId: product.title),
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

  const ProductWishlistButton({Key key, this.productId}) : super(key: key);

  @override
  _ProductWishlistButtonState createState() => _ProductWishlistButtonState();
}

class _ProductWishlistButtonState extends State<ProductWishlistButton> {
  bool _wishHover;

  @override
  void initState() {
    super.initState();
    _wishHover = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCardBloc, ProductCardState>(
        builder: (context, state) {
      return Container(
        padding: EdgeInsets.all(6.0),
        child: MouseRegion(
          onEnter: (event) {
            setState(() {
              _wishHover = !state.isItemInWishList;
            });
          },
          onExit: (event) {
            setState(() {
              _wishHover = state.isItemInWishList;
            });
          },
          child: _wishHover
              ? GestureDetector(
                  onTap: () {
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
                  ),
                ),
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
  int _value = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
          value: _value,
          items: [
            DropdownMenuItem(
              child: Text("Featured"),
              value: 1,
            ),
            DropdownMenuItem(
              child: Text("Price: Low To High"),
              value: 2,
            ),
            DropdownMenuItem(child: Text("Price: High To Low"), value: 3),
            DropdownMenuItem(child: Text("Avg Customer Review"), value: 4),
          ],
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          }),
    );
  }
}

class _AddToCartButton extends StatefulWidget {
  @override
  __AddToCartButtonState createState() => __AddToCartButtonState();
}

class __AddToCartButtonState extends State<_AddToCartButton> {
  bool _visible = false;

  Widget _buildWidget(bool _on) {
    if (_on) {
      return AnimatedContainer(
        width: 400,
        color: Colors.white.withAlpha(180),
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Icon(Icons.add_shopping_cart),
      );
    } else {
      return Container(width: 400, height: 40, margin: EdgeInsets.all(0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onEnter: (event) {
          setState(() {
            _visible = true;
          });
        },
        onExit: (event) {
          setState(() {
            _visible = false;
          });
        },
        child: _buildWidget(_visible));
  }
}
