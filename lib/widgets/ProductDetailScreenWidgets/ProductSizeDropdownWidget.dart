
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductSizeDropdown extends StatefulWidget {
  @override
  _ProductSizeDropdownState createState() => _ProductSizeDropdownState();
}

class _ProductSizeDropdownState extends State<ProductSizeDropdown> {

  int selectedValue = 1;

  @override
  Widget build(BuildContext context) {
     return DropdownButtonHideUnderline(
       child: DropdownButton(
           value: selectedValue,
           elevation: 0,
           focusColor: Colors.red,
           iconDisabledColor: Colors.black,
           iconEnabledColor: Colors.black,
           items: [

             DropdownMenuItem(

               child: Container(
                 alignment: Alignment.centerRight,
                 child: Text('S', textAlign: TextAlign.end,),
               ), value: 1),
             DropdownMenuItem(

                 child: Container(
                   alignment: Alignment.centerRight,
                   child: Text('M'),
                 ), value: 2),
             DropdownMenuItem(

                 child: Container(
                   alignment: Alignment.centerRight,
                   child: Text('L'),
                 ), value: 3),
             DropdownMenuItem(

                 child: Container(
                   alignment: Alignment.centerRight,
                   child: Text('XL'),
                 ), value: 4),
             DropdownMenuItem(

                 child: Container(
                   alignment: Alignment.centerRight,
                   child: Text('XXL'),
                 ), value: 5),
             DropdownMenuItem(

                 child: Container(
                   alignment: Alignment.centerRight,
                   child: Text('XXXL'),
                 ), value: 6),

           ],
           onChanged: (value) {
             setState(() {
               selectedValue = value;
             });
           }),
     );;
  }
}
