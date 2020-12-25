
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/models/productVariantColorModel.dart';

class ProductVariantColorWidget extends StatefulWidget {

  final List<ProductVariantColor> colorList;
  List<ProductVariantColor> selectedColor;
  String productID;
  String size;
  Function (String) onColorSelected;
  List<ProductVariantColor> selectedVariantColor;

  ProductVariantColorWidget({Key key, this.colorList, this.size, this.selectedColor, this.productID}) : super(key: key);

  @override
  _ProductVariantColorState createState() => _ProductVariantColorState();
}

class _ProductVariantColorState extends State<ProductVariantColorWidget> {

  int selectedColorCount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedColorCount = widget.selectedColor.length;
    widget.selectedVariantColor.clear();

  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.colorList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              widget.selectedVariantColor.add(widget.colorList[index]);
              widget.selectedColor = widget.colorList[index];
              BlocProvider.of<ProductDetailBloc>(context).add(LoadProductVariantDetail(widget.productID, widget.selectedColor, widget.size));
            });
          },
          child: Container(
            padding: EdgeInsets.all(4.0),
            margin: EdgeInsets.only(left: 6.0),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(int.parse("FF" + widget.colorList[index].colorHexCode, radix: 16)),
                border: Border.all(width: 0.5, color: Colors.black)),
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Color(int.parse(widget.colorList[index].colorHexCode, radix: 16)),
            ),
          ),
        );
      },
    );
  }
}
