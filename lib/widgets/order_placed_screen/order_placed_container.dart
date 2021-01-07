import 'package:flutter/material.dart';
import '../../config/configs.dart';
import '../../models/models.dart';
import '../widgets.dart';

class OrderPlacedContainer extends StatelessWidget {
  final Order order;
  //Order Placed Container: List of Products
  const OrderPlacedContainer({Key key, this.order}) : super(key: key);

  double calcTotal(){
    double total = 0;
    for (int i = 0; i < order.orderedProducts.length; i++) {
      total = total + order.orderedProducts[i].discountPrice;
    }

    return total;

  }

  @override
  Widget build(BuildContext context) {

    return Container(

      child: Padding(

        padding: const EdgeInsets.only(
          left: 32.0,
          right: 32.0,
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Row(

              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Container(margin: EdgeInsets.only(right: 16),child: Icon(Icons.check_circle_outline_rounded,color: Colors.green,size: 48)),

                Expanded(

                  child: Text(

                  Strings.orderPlaced,

                  style: TextStyle(

                    color: Colors.green,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),),
                Container(child: Text('Order ID : ',style: TextStyle(fontSize: 20,color: Colors.grey[500],fontWeight: FontWeight.w600,),),),
                Container(child: Text(order.orderID,style: TextStyle(fontSize: 24,color: Palette.secondaryColor),),),

              ],

            ),


            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.orderedProducts.length,
                  itemBuilder: (context, index) {
                    return OrderPlacedItem(
                      orderedProduct: order.orderedProducts[index],
                    );
                  }),
            ),

            // Total Price of the products
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(

                  margin: EdgeInsets.only(right: 80),

                  child: Text(
                    Strings.total + '(${order.orderedProducts.length} Items) : ₹ ${calcTotal()}',
                    style: TextStyle(
                      fontSize: 32,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
