import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/MyWalletProvider.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';
import 'package:provider/provider.dart';

class MyWallet extends StatelessWidget{

  bool init = false;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => MyWalletProvider(),
        child: Consumer<MyWalletProvider>(
          builder: (BuildContext context, MyWalletProvider value, Widget child) {

            if (!init) {
              Provider.of<MyWalletProvider>(context, listen: false).initWallet();
              init = true;
            }

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


              child: Visibility(

                visible: value.isInitialize,

                replacement: Container(

                  width: 400,
                  height: 400,

                  child: Center(child: CircularProgressIndicator(),),

                ),

                child: Column(
                  children: [

                    Container(

                      alignment: Alignment.centerLeft,

                      margin: EdgeInsets.only(bottom: 8),

                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                      child: LabelTag('My Wallet '),

                    ),

                    Container(

                        margin: EdgeInsets.only(top: 16,left: 16),
                        alignment: Alignment.centerLeft,
                        child: Text('Wallet Amount',style: TextStyle(fontSize: 18,),)),

                    Container(

                        margin: EdgeInsets.only(top: 8,left: 16),
                        alignment: Alignment.centerLeft,
                        child: Text('₹ ${(value.walletAmount!=null)?value.walletAmount:0}',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),

                    Container(

                        margin: EdgeInsets.only(top: 16,left: 16),
                        alignment: Alignment.centerLeft,
                        child: Text('Wallet Amount Used',style: TextStyle(fontSize: 18,),)),

                    Container(

                        margin: EdgeInsets.only(top: 8,left: 16,bottom: 32),
                        alignment: Alignment.centerLeft,
                        child: Text('₹ ${(value.walletAmountUsed!=null)?value.walletAmountUsed:0}',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),)),




                  ],
                ),
              ),

            );

          },
        ));

  }



}