
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/DBHandler/footerRepository.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/service/navigation_service.dart';

import '../../main.dart';
import '../../routes.dart';

class FooterNew extends StatelessWidget {
  final ScrollController scrollController;

  const FooterNew({Key key, this.scrollController}) : super(key: key);

  _moveUp() {
    scrollController.animateTo(0, curve: Curves.linear, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.grey[200],
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 32.0),
      padding: EdgeInsets.symmetric(vertical: 32.0),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [

          SizedBox(height: 50.0,),

          Container(
            color: Colors.black87,
            height: 0.5,
          ),

          SizedBox(height: 50,),

          Container(
            color: Colors.grey[300],
            padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 32.0),

            child: Row(

              mainAxisAlignment: MainAxisAlignment.start,

              children: [

                Expanded(
                  flex:2,

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Wrap(
                        children: [

                          Text(
                            Strings.follow.toUpperCase(),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                              color: Palette.darkGrey
                            ),
                          ),

                          SizedBox(width: 10,),

                          Text(
                            Strings.hashTagLivingDesire.toUpperCase(),
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 20,),

                      Wrap(
                        children: [

                          Material(
                            elevation: 2.0,
                            shape: CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Ink.image(
                              image: AssetImage('assets/images/facebook.png'),
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ),

                          SizedBox(width: 30,),

                          Material(
                            elevation: 2.0,
                            shape: CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Ink.image(
                              image: AssetImage('assets/images/twitter.png'),
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ),

                          SizedBox(width: 30,),

                          Material(
                            elevation: 2.0,
                            shape: CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Ink.image(
                              image: AssetImage('assets/images/linkedin.png'),
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ),

                          SizedBox(width: 30,),

                          Material(
                            elevation: 2.0,
                            shape: CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: Colors.transparent,
                            child: Ink.image(
                              image: AssetImage('assets/images/instagram.png'),
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                              child: InkWell(
                                onTap: () {},
                              ),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  height: 120,
                  width: 0.5,
                  color: Colors.black,
                ),

                SizedBox(width: 32,),

                Expanded(
                  flex:1,
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        Strings.contactUs.toUpperCase(),
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                            color: Palette.darkGrey
                        ),
                      ),

                      SizedBox(height: 20,),

                      Row(

                        children: [

                          Icon(Icons.call, size: 24, color: Colors.black,),

                          SizedBox(width: 24,),

                          Text(
                          Strings.contactUsPhone,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.normal
                            ),
                          ),

                        ],
                      ),

                      SizedBox(height: 16,),

                      Row(

                        children: [

                          Icon(Icons.mail_sharp, size: 24, color: Colors.black,),

                          SizedBox(width: 24,),

                          Text(
                           Strings.contactUsEmail,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.normal
                            ),
                          ),

                        ],
                      ),


                    ],
                  ),
                )
              ],
            ),
          ),

          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(

                padding: EdgeInsets.symmetric(horizontal: 16.0),
                margin: EdgeInsets.only(top: 8.0),

                child: InkWell(

                  onTap: () {
                    _moveUp();
                  },

                  child: Wrap(

                    children: [

                      Text(
                        Strings.backToTop.toUpperCase(),
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600
                        ),
                      ),

                      SizedBox(width: 10,),

                      Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.black,
                        size: 24,
                      )

                    ],
                  ),
                ),

              ),

            ],
          ),

          SizedBox(height: 8.0,),

          Container(
            color: Colors.black87,
            height: 0.5,
          ),

          SizedBox(height: 8.0,),

          Wrap(
            alignment: WrapAlignment.center,
            children: [

              InkWell(

                onTap: () {

                  locator<NavigationService>().navigateTo(RoutesConfiguration.ABOUT_US);

                },
                child: Text(
                  Strings.aboutUs.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14
                  ),
                ),
              ),

              SizedBox(width: 40,),

              Text(
                Strings.shippingPolicy.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14
                ),
              ),

              SizedBox(width: 40,),

              Text(
                Strings.cancellationAndReturn.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14
                ),
              ),

              SizedBox(width: 40,),

              Text(
                Strings.privacyPolicy.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14
                ),
              ),

              SizedBox(width: 40,),

              Text(
                Strings.termsAndConditions.toUpperCase(),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                    fontSize: 14
                ),
              ),
            ],
          ),

          SizedBox(height: 100,)
        ],
      ),

    );

  }
}
