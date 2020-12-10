
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSizeDropdown extends StatefulWidget {

  final List<String> productSizeList;

  const ProductSizeDropdown({Key key, this.productSizeList}) :  super(key: key);


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

    dropdownValue = widget.productSizeList.first;

  }

  void getDropDownItem(){

    setState(() {
      holder = dropdownValue ;
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
