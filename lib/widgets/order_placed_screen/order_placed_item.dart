import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:living_desire/widgets/CustomContainer.dart';
import '../../models/models.dart';
import '../../data/data.dart';
import '../../config/configs.dart';
import '../../routes.dart';

class OrderPlacedItem extends StatelessWidget {
  final OrderedProduct orderedProduct;

  const OrderPlacedItem({
    Key key,
    this.orderedProduct,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Get Ordered Product Id and match to product

    return Container(

      margin: EdgeInsets.only(left: 32,right: 64,top: 16,bottom: 16),

      child: Column(

        children: [
          Row(

            children: [

              Container(

                decoration: BoxDecoration(

                    border: Border.all(color: Palette.secondaryColor),

                    color: Colors.grey[200]

                ),

                child: Image.network(

                  orderedProduct.imageUrl,

                  width: 120,

                  height: 160,

                ),

              ),

              Expanded(

                child: Container(

                  margin: EdgeInsets.only(left: 32),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      InkWell(

                         onTap: (){

                           locator<NavigationService>().navigateTo(
                               RoutesConfiguration.PRODUCT_DETAIL,
                             queryParams: {
                               "pid": orderedProduct.productID,
                               "vid": orderedProduct.variantID,
                             },newTab: true);

                         },

                          child: Container(child: Text(orderedProduct.productName,style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w100,),),)
                      ),



                      Row(

                        children: [

                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Container(

                                margin: EdgeInsets.only(top: 32,bottom: 8),

                                child: Row(

                                  children: [
                                    
                                    (orderedProduct.colour.length > 1)?
                                      MyCustomContainer(
                                        progress: 0.5,
                                        size: 40,
                                        progressColor: orderedProduct.colour.first,
                                        backgroundColor: orderedProduct.colour.elementAt(1),
                                      ) : Container(

                                      margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                      width: 40,
                                      height: 40,
                                      decoration: new BoxDecoration(
                                        color: orderedProduct.colour.first,
                                        shape: BoxShape.circle,
                                      ),
                                    ),

                                    Container(

                                      margin: EdgeInsets.only(left: 32),
                                      child: Row(

                                        children: [

                                          Text(' Size : ',style: TextStyle(color: Palette.secondaryColor,fontSize: 18),),

                                          Text(' ${orderedProduct.size} ',style: TextStyle(color: Palette.secondaryColor,fontSize: 18,fontWeight: FontWeight.bold),),


                                        ],

                                      ),

                                    ),

                                    Container(

                                      margin: EdgeInsets.only(left: 32),
                                      child: Row(

                                        children: [

                                          Text(' Qty : ',style: TextStyle(color: Palette.secondaryColor,fontSize: 18),),

                                          Text(' ${orderedProduct.quantity} ',style: TextStyle(color: Palette.secondaryColor,fontSize: 18,fontWeight: FontWeight.bold),),


                                        ],

                                      ),

                                    )

                                  ],

                                ),
                              ),

                            ],
                          ),

                        ],
                      )


                    ],

                  ),
                ),

              ),

              Container(

                margin: EdgeInsets.only(left: 64),

                child: Column(

                  children: [

                    Container(

                      padding: EdgeInsets.symmetric(horizontal: 16),

                      margin: EdgeInsets.only(bottom: 64),

                      child: Visibility(visible : true,child: Text('₹ ${orderedProduct.discountPrice}',style: TextStyle(color: Palette.secondaryColor,fontSize: 28,fontWeight: FontWeight.bold),)),

                    ),

                  ],

                ),

              )

            ],

          ),
          Container(

            margin: EdgeInsets.only(top: 32),

            width: double.infinity,
            height: 1,
            color: Colors.grey[500],

          )
        ],
      ),

    );

  }
}
