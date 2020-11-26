


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/provider_models/ProductDetailModel.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/customButtonWidgets.dart';
import 'package:living_desire/widgets/wishListWidget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget{
  bool init = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(lazy:false,
      create: (context) => ProductDetailModel(),
      child: Consumer<ProductDetailModel> (
        // ignore: missing_return
        builder: (BuildContext context, ProductDetailModel productDetail, Widget child){
          if(!init) {
            Provider.of<ProductDetailModel> (context, listen: false).getAuthID();
            init = true;
          }

          return ProductDetailStatelessScreen (productDetail:productDetail);

        }
      ),



    );

  }

}

class ProductDetailStatelessScreen extends StatelessWidget {

  final ProductDetailModel productDetail;

  const ProductDetailStatelessScreen({Key key, this.productDetail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(

      appBar: CustomAppBar(),

      body: SingleChildScrollView(

        physics: ScrollPhysics(),

        child: Container(


          child: Column(

            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // list of images
                  Column(
                    children: [

                      Container(
                        width: MediaQuery.of(context).size.width*0.06,
                        height: 30,
                        color: Palette.lightGrey,


                        child: IconButton(
                          alignment: Alignment.center,
                          icon: Icon(Icons.keyboard_arrow_up),
                          color: Colors.black,

                        ),
                      ),


                      Container(
                        width: MediaQuery.of(context).size.width*0.06,
                        height: MediaQuery.of(context).size.height*0.45,
                        margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),

                        color: Palette.lightGrey,
                        alignment: Alignment.center,
                      ),


                      Container(
                        width: MediaQuery.of(context).size.width*0.06,
                        height: 30,
                        color: Palette.lightGrey,


                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  // main product image(enlarged view)
                  Column(
                    children: [

                      // enlarged image
                      Container(
                        height: MediaQuery.of(context).size.height*0.45,
                        width: MediaQuery.of(context).size.width*0.2,

                        margin: EdgeInsets.only(left: 8.0, top: 44.0),

                        decoration: new BoxDecoration(
                          color: Palette.lightGrey,
                        ),

                        child: Stack(

                          children: [
                            Placeholder(),

                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(

                                padding: EdgeInsets.all(8.0),

                                child: ProductWishlistButton(),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // action buttons
                      Container(
                        width: MediaQuery.of(context).size.width*0.2,
                        height: 50,
                        margin: EdgeInsets.only(left: 8.0, top: 8.0),


                        child: Row(
                          children: [
                            //add to cart button
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: double.infinity,
                                child: CustomWidgetButton(
                                  onPressed: () {

                                  },
                                  text: Strings.addToCart,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: 10,
                            ),
                            // buy now button
                            Expanded(
                              flex: 1,
                              child: Container(
                                padding: EdgeInsets.only(right: 0.0),
                                child: Container(
                                  height: double.infinity,
                                  child: CustomWidgetButton(
                                    onPressed: () {

                                    },
                                    backGroundColor: Colors.black,
                                    textColor: Colors.white,
                                    text: Strings.buyNow,
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      )
                    ],
                  ),

                  // description of product
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Classic Filled Bean Bags",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black
                          ),
                        ),
                      ),

                    ],
                  ),

                ],
              ),


            ],
          ),
        ),

      ),

    );



    throw UnimplementedError();
  }



}