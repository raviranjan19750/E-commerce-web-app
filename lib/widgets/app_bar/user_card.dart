import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../config/configs.dart';

class UserCard extends StatelessWidget {

  bool isLoggedIn;

  String userNNme,phoneNumber;

  UserCard({this.isLoggedIn,this.userNNme,this.phoneNumber});

  Container returnView(bool isLoggedIn){

    if(isLoggedIn){

      return Container(

        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 12),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(

          color: Palette.secondaryColor,
          borderRadius: BorderRadius.circular(4),

        ),

        child: InkWell(

          onTap: (){},
          child: Row(

            children: [
              Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Text('Login as Vardaan Chakraborty',style: TextStyle(color: Palette.primaryColor),),
                  Text('8617878497',style: TextStyle(color: Palette.primaryColor),),

                ],
              ),
              
              Container(

                margin: EdgeInsets.only(left: 16),

                child: Icon(
                    Icons.arrow_drop_down,
                    color: Palette.primaryColor,
                    size: 48,

                ),
              )

            ],
          ),

        ),

      );

    }
    else{

      return Container(

        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Palette.secondaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        // Login Button
        child: InkWell(
          onTap: () {},

          child: Text(Strings.loginText,
            style: TextStyle(color: Colors.white),

          ),
        ),
      );

    }

  }

  @override
  Widget build(BuildContext context) {
    // Configure with firebase user login/signup

    return returnView(true);

  }
}
