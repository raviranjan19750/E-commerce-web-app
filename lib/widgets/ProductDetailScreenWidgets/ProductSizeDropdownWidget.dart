import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/productVariantColorModel.dart';

class ProductSizeDropdown extends StatefulWidget {
  List<String> productSizeList;
  String productID;
  String productSize;

  List<ProductVariantColor> initialSelectedColor;
  List<AllVariant> productAllVariant;

  ProductSizeDropdown(
      {Key key,
      this.productSizeList,
      this.productID,
      this.productSize,
      this.initialSelectedColor,
      this.productAllVariant})
      : super(key: key);

  @override
  _ProductSizeDropdownState createState() => _ProductSizeDropdownState();
}

class _ProductSizeDropdownState extends State<ProductSizeDropdown> {
  String dropdownValue;
  String holder;
  String variantID;
  List<String> selectedVariantSizeList = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSizeList();
    dropdownValue = selectedVariantSizeList.last;
  }

  void getSizeList() {
    if (widget.initialSelectedColor.length == 2) {
      for (int i = 0; i < widget.productAllVariant.length; i++) {
        if (widget.productAllVariant[i].colour.length == 2) {
          if (widget.initialSelectedColor[0].colorHexCode ==
                  widget.productAllVariant[i].colour[0] &&
              widget.initialSelectedColor[1].colorHexCode ==
                  widget.productAllVariant[i].colour[1]) {
            selectedVariantSizeList.add(widget.productAllVariant[i].size);
          }
        }
      }
    } else {
      for (int i = 0; i < widget.productAllVariant.length; i++) {
        if (widget.productAllVariant[i].colour.length == 1) {
          if (widget.initialSelectedColor[0].colorHexCode ==
              widget.productAllVariant[i].colour[0]) {
            selectedVariantSizeList.add(widget.productAllVariant[i].size);
          }
        }
      }
    }
  }

  String getVariantID(String dropdownValue) {
    if (widget.initialSelectedColor.length == 2) {
      for (int i = 0; i < widget.productAllVariant.length; i++) {
        if (widget.productAllVariant[i].colour.length == 2) {
          if (widget.initialSelectedColor[0].colorHexCode ==
                  widget.productAllVariant[i].colour[0] &&
              widget.initialSelectedColor[1].colorHexCode ==
                  widget.productAllVariant[i].colour[1] &&
              dropdownValue == widget.productAllVariant[i].size) {
            return widget.productAllVariant[i].variantId;
          }
        }
      }
    } else {
      for (int i = 0; i < widget.productAllVariant.length; i++) {
        if (widget.productAllVariant[i].colour.length == 1) {
          if (widget.initialSelectedColor[0].colorHexCode ==
                  widget.productAllVariant[i].colour[0] &&
              dropdownValue == widget.productAllVariant[i].size) {
            return widget.productAllVariant[i].variantId;
          }
        }
      }
    }

    return "";
  }

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        elevation: 0,
        onChanged: (value) {
          setState(() {
            dropdownValue = value;
            variantID = getVariantID(dropdownValue);
            BlocProvider.of<ProductDetailBloc>(context)
                .add(LoadProductDetail(widget.productID, variantID));
          });
        },
        items: selectedVariantSizeList
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
