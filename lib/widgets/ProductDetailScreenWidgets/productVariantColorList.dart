import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/productVariantColorModel.dart';

class ProductVariantColorWidget extends StatefulWidget {
  final List<List<ProductVariantColor>> colorList;
  List<ProductVariantColor> selectedColor;
  List<AllVariant> productAllVariant;
  String variantID;
  String productID;
  String size;
  Function(String) onColorSelected;
  List<ProductVariantColor> selectedVariantColor;

  ProductVariantColorWidget(
      {Key key, this.colorList, this.size, this.selectedColor, this.productID})
      : super(key: key);

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
              // widget.selectedVariantColor.add(widget.colorList[index]);
              widget.selectedColor = widget.colorList[index];
              for (var i = 0; i < widget.productAllVariant.length; i++) {
                if (widget.selectedColor ==
                        widget.productAllVariant[i].colour &&
                    widget.size == widget.productAllVariant[i].size) {}
              }
              BlocProvider.of<ProductDetailBloc>(context).add(
                  LoadProductVariantDetail(
                      widget.productID, widget.selectedColor, widget.size));
            });
          },
          child: widget.colorList[index].length == 2
              ? Container(
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.only(left: 6.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          color: widget.colorList[index][0].colorHexCode,
                        ),
                        height: 8,
                        width: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          color: widget.colorList[index][1].colorHexCode,
                        ),
                        height: 8,
                        width: 16,
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.only(left: 6.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: widget.colorList[index][0].colorHexCode,
                  ),
                ),
        );
      },
    );
  }
}
