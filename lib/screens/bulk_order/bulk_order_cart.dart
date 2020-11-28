import 'package:flutter/material.dart';

class BulkOrderCart extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Container(

      height: 420,
      width: 360,

      decoration: BoxDecoration(

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )],

        color: Colors.white

      ),

    );

  }



}