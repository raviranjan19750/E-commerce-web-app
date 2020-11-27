import 'package:flutter/material.dart';

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
            onChanged: (val) => {},
          ),
          FilterCheckBox(
            filterLabel: "Medium(M)",
            onChanged: (val) => {},
          ),
          FilterCheckBox(
            filterLabel: "Large(L)",
            onChanged: (val) => {},
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
        child: _wishHover ? Icon(Icons.favorite, color: Colors.red,) : Icon(Icons.favorite_border_outlined, color: Colors.red,),
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
            ),
          ],
          onChanged: (value) {
            setState(() {
              _value = value;
            });
          }),
    );
  }
}