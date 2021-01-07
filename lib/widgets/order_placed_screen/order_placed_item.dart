import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../models/models.dart';
import '../../data/data.dart';
import '../../config/configs.dart';

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

      margin: EdgeInsets.only(left: 64,right: 64,top: 16,bottom: 16),

      child: Column(

        children: [
          Row(

            children: [

              Container(

                decoration: BoxDecoration(

                    border: Border.all(color: Palette.secondaryColor),

                    color: Colors.grey[200]

                ),

                child: Image(

                  height: 200,

                  width: 150,

                  image: AssetImage('assets/images/logo.jpeg'),

                ),

              ),

              Expanded(

                child: Container(

                  margin: EdgeInsets.only(left: 32),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Container(child: Text('Classic Filled Bean Bag with Beans',style: TextStyle(fontSize: 28,color: Colors.black,fontWeight: FontWeight.w100),),),



                      Row(

                        children: [

                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Container(

                                margin: EdgeInsets.only(top: 32,bottom: 8),

                                child: Row(

                                  children: [

                                    Container(

                                      margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                      width: 40,
                                      height: 40,
                                      decoration: new BoxDecoration(
                                        color: Colors.redAccent,
                                        shape: BoxShape.circle,
                                      ),
                                    ),

                                    Container(

                                      margin: EdgeInsets.only(left: 32),
                                      child: Row(

                                        children: [

                                          Text(' Size : ',style: TextStyle(color: Palette.secondaryColor,fontSize: 20),),

                                          Text(' S ',style: TextStyle(color: Palette.secondaryColor,fontSize: 20,fontWeight: FontWeight.bold),),


                                        ],

                                      ),

                                    ),

                                    Container(

                                      margin: EdgeInsets.only(left: 32),
                                      child: Row(

                                        children: [

                                          Text(' Qty : ',style: TextStyle(color: Palette.secondaryColor,fontSize: 20),),

                                          Text(' 32 ',style: TextStyle(color: Palette.secondaryColor,fontSize: 20,fontWeight: FontWeight.bold),),


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

                      child: Visibility(visible : true,child: Text('Rs 5000',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),)),

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Product Image
              //Text('Product Image'),
              Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: Image.network(
                  orderedProduct.imageUrl,
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(orderedProduct.productName),
                      Text(orderedProduct.discountPrice.toString()),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: [
                        //TODO: Color of the product
                        CircleAvatar(
                          backgroundColor: Colors.black,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        // Get Size from product variants
                        Text(Strings.size),
                        SizedBox(
                          width: 15,
                        ),

                        // Order product Quantity
                        Text(Strings.qty + orderedProduct.quantity.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Divider(
          thickness: 0.5,
          color: Colors.black,
        ),
      ],
    );
  }
}
