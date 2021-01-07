import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../config/configs.dart';
import '../widgets.dart';
import '../../models/models.dart';

class OrderPlacedStatusContainer extends StatelessWidget {
  final Order order;

  String dateFormatter(DateTime date){


    return new DateFormat.yMMMd().format(date);

  }

  const OrderPlacedStatusContainer({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.only(left: 32,right: 32,top: 16,bottom: 32),

      decoration: BoxDecoration(

        color: Colors.white,

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )],

      ),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [



          Container(
  
                margin : EdgeInsets.only(top: 8,bottom: 8),
  
                child: Row(
  
                  children: [
  
                    Container(
  
                      child: Text('Placed On           :',style: TextStyle(color: Colors.grey[500]),),
  
                    ),
  
                    Container(
  
                      margin: EdgeInsets.only(left: 24),
  
                      child: Text(' ${dateFormatter(order.placedDate)}',style: TextStyle(color: Palette.secondaryColor),),
  
                    ),
  
                  ],
  
                ),
              ),
          Container(
  
            margin : EdgeInsets.only(top: 8,bottom: 8),
            child: Row(
  
              children: [
  
                Container(
  
                  child: Text('Delivery Address :',style: TextStyle(color: Colors.grey[500]),),
  
                ),
  
                Container(

                  width: 320,
  
                  margin: EdgeInsets.only(left: 24),
  
                  child: Text('${order.address} \nPincode : ${order.pincode}',style: TextStyle(color: Palette.secondaryColor),),
  
                ),
  
              ],
  
            ),
          ),
          Container(
  
            margin : EdgeInsets.only(top: 8,bottom: 8),
            child: Row(
  
              children: [
  
                Container(
  
                  child: Text('Phone Number   :',style: TextStyle(color: Colors.grey[500]),),
  
                ),
  
                Container(
  
                  margin: EdgeInsets.only(left: 24),
  
                  child: Text(' ${order.phone}',style: TextStyle(color: Palette.secondaryColor),),
  
                ),
  
              ],
  
            ),
          ),

           /*   Text(Strings.deliveryAddress + order.name + order.address),
          //Phone Number
          Text(Strings.phoneNumber + order.phone),*/

          TrackingStatusBar(),


          Container(
            child: InkWell(
              onTap: (){},

              child: Container(
                width: 400,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Palette.secondaryColor,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                // Place Order Button
                child: Text(
                  Strings.downloadInvoice,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 20,
          ),


          InkWell(
            onTap: (){},
            child: Container(
              width: 400,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  width: 0.5,
                  color: Colors.black,
                  style: BorderStyle.solid,
                ),
              ),
              // Place Order Button
              child: Text(
                Strings.continueShopping,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }
}
