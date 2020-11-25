import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class AllProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Living Desire"),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.85,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Filters", style: TextStyle(fontWeight: FontWeight.w600),),
                    FilterDropDown()
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Column(
                          children: [
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard(),
                            Divider(
                              thickness: 2,
                            ),
                            FilterCard()
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 4,
                      fit: FlexFit.tight,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Wrap(
                          spacing: 12,
                          runSpacing: 20,
                          children: [
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard(),
                            ProductCard()
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatefulWidget {
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  double _elevation = 0;
  double _size = 1;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          _elevation = 20;
          _size = 1.12;
        });
      },
      onExit: (event) {
        setState(() {
          _elevation = 0;
          _size = 1;
        });
      },
      child: Card(
        elevation: _elevation,
        child: Stack(
          children: [
            Container(
              height: 200,
              width: 150,
            ),
            Positioned(
              right: 0,
              top: 0,
              child: ProductWishlistButton(),
            )
          ],
        ),
      ),
    );
  }
}

class FilterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Category"),
          SizedBox(
            height: 10,
          ),
          FilterCheckBox(
            filterLabel: "Small(S)",
          ),
          FilterCheckBox(
            filterLabel: "Medium(M)",
          ),
          FilterCheckBox(
            filterLabel: "Large(L)",
          ),
        ],
      ),
    );
  }
}

class FilterCheckBox extends StatelessWidget {
  final ValueChanged<bool> onChanged;
  final String filterLabel;
  const FilterCheckBox({Key key, this.onChanged, this.filterLabel})
      : assert(filterLabel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.85,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.all(0.0),
            child: Checkbox(
              value: true,
              onChanged: onChanged,
            ),
          ),
          SizedBox(width: 10,),
          Text(this.filterLabel)
        ],
      ),
    );
  }
}

class ProductWishlistButton extends StatefulWidget {
  @override
  _ProductWishlistButtonState createState() => _ProductWishlistButtonState();
}

class _ProductWishlistButtonState extends State<ProductWishlistButton> {
  bool _wishHover;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _wishHover = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.0),
      child: MouseRegion(
        onEnter: (event) {
          setState(() {
            _wishHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            _wishHover = false;
          });
        },
        child: _wishHover ? Icon(Icons.thumb_up_alt) : Icon(Icons.thumb_up_alt_outlined),
      ),
    );
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
            DropdownMenuItem(
                child: Text("Price: High To Low"),
                value: 3
            ),
            DropdownMenuItem(
                child: Text("Avg Customer Review"),
                value: 4
            )
          ],
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          }),
    );
  }
}

