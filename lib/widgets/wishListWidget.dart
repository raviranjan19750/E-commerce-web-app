import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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