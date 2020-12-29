
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/productVariantColorModel.dart';

class ProductSizeDropdown extends StatefulWidget {

  final List<String> productSizeList;
  final String productColor;
  final String productID;
  final String variantID;
  final String productSize;

  const ProductSizeDropdown({Key key, this.productSizeList, this.productColor, this.productID, this.variantID, this.productSize}) :  super(key: key);


  @override
  _ProductSizeDropdownState createState() => _ProductSizeDropdownState();
}

class _ProductSizeDropdownState extends State<ProductSizeDropdown> {

  String dropdownValue ;
  String holder  ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dropdownValue = widget.productSize;

  }

  void getDropDownItem(){

    setState(() {
      holder = dropdownValue ;
      // royte
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
               BlocProvider.of<ProductDetailBloc>(context).add(LoadProductVariantDetail(widget.productID, widget.variantID, widget.productColor, dropdownValue));
             });
           },

           items: widget.productSizeList.map<DropdownMenuItem<String>>((String value) {
             return DropdownMenuItem<String>(
               value: value,
               child: Text(value),
             );
           }).toList(),
           ),
     );
  }
}
