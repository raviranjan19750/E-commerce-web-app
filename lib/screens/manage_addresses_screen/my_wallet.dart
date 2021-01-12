import 'package:flutter/material.dart';

class MyWallet extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.only(left:32),
      width: 400,

      decoration: BoxDecoration(

          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 2),
              blurRadius: 4.0,
            )],

          color: Colors.white

      ),


      child: Column(
        children: [

          Container(

            margin: EdgeInsets.only(top: 32,left: 16),

            child: Row(

              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Icon(Icons.account_balance_wallet_outlined),

                Container(

                    margin: EdgeInsets.only(left: 8),
                    alignment: Alignment.centerLeft,
                    child: Text('My Wallet',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),

          Container(

              margin: EdgeInsets.only(top: 16,left: 16),
              alignment: Alignment.centerLeft,
              child: Text('Wallet Amount',style: TextStyle(fontSize: 18,),)),

          Container(

              margin: EdgeInsets.only(top: 8,left: 16),
              alignment: Alignment.centerLeft,
              child: Text('Rs 50000',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),

          Container(

              margin: EdgeInsets.only(top: 16,left: 16),
              alignment: Alignment.centerLeft,
              child: Text('Wallet Amount Used',style: TextStyle(fontSize: 18,),)),

          Container(

              margin: EdgeInsets.only(top: 8,left: 16,bottom: 32),
              alignment: Alignment.centerLeft,
              child: Text('Rs 2500',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),




        ],
      ),

    );

  }



}