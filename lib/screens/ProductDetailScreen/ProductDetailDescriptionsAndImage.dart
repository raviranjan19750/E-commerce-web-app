import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/widgets/bullet.dart';
import 'package:living_desire/widgets/customButtonWidgets.dart';
import 'package:living_desire/widgets/wishListWidget.dart';

class ProductDetailDescriptionAndImage extends StatelessWidget {

  final List<Color> itemColor = itemColors;
  final List<String> itemDescriptions = productItemDescriptions;

  int itemQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
// ignore: missing_return
        builder: (context, state) {
          if (state is ProductDetailLoading) {
            return CircularProgressIndicator();
          } else if (state is ProductDetailLoadingSuccessful) {
            return  Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // list of images
                Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.06,
                        height: 30,
                        color: Palette.lightGrey,
                        child: IconButton(
                          alignment: Alignment.center,
                          icon: Icon(Icons.keyboard_arrow_up),
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.06,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.45,
                        margin: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 0.0),
                        color: Palette.lightGrey,
                        alignment: Alignment.center,
                      ),
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.06,
                        height: 30,
                        color: Palette.lightGrey,
                        child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // main product image(enlarged view)
                Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: Column(
                    children: [
                      // enlarged image
                      Container(
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.55,
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.22,
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
                                child: Card(
                                  elevation: 4.0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: CircleBorder(),
                                  child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: ProductWishlistButton()),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

// action buttons
                      Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.22,
                        height: 50,
                        margin: EdgeInsets.only(left: 0.0, top: 8.0),
                        child: Row(
                          children: [
//add to cart button
                            Expanded(
                              flex: 1,
                              child: Container(
                                height: double.infinity,
                                child: CustomWidgetButton(
                                  onPressed: () {},
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
                                    onPressed: () {},
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
                ),

                // description of product
                Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Classic Filled Bean Bags",
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: Text(
                          "Rs 2000",
                          style: TextStyle(
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Rs 2000",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      ),
                      Container(
                        child: Text(
                          "You save Rs 50",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  color: Colors.black,
                                ),
                                Container(
                                  width: 120,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 0.0),
                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      maxLength: 6,
                                      onChanged: (val) {},
                                      cursorColor: Colors.black,
                                      decoration: InputDecoration(
                                          labelText: 'Check Availability',
                                          focusColor: Colors.grey,
                                          hoverColor: Colors.grey,
                                          fillColor: Colors.grey,
                                          border: InputBorder.none,
                                          labelStyle: TextStyle(
                                              color: Colors.black54),
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          counterText: "")),
                                ),
                                Text(
                                  Strings.check,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              ],
                            ),

                            Container(
                              width: 220,
                              padding: EdgeInsets.all(0.0),
                              margin: EdgeInsets.all(0.0),
                              child: Divider(
                                thickness: 1.0,
                                height: 0.0,
                                color: Colors.black,
                              ),
                            ),

                            Text(
                              Strings.available.toUpperCase(),
                              style: TextStyle(
                                  color: Palette.green,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ),

//list of color
//todo Set lst of color
                            Container(
//width: 150,
                              height: 50,
                              margin: EdgeInsets.only(top: 16.0),

                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: itemColor.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
//todo show selectd color
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(4.0),
                                      margin: EdgeInsets.only(left: 6.0),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 0.5, color: Colors.black)),
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: itemColor[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

// setting size and quantity button
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
//dropdown menu for sizes
                                  Container(),

                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: IconButton(
                                            onPressed: () {},
                                            iconSize: 14,
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            icon: Icon(Icons.remove),
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 0.0),
                                          child: Text(
                                            itemQuantity.toString(),
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black),
                                          ),
                                        ),
                                        Container(
                                          child: IconButton(
                                            onPressed: () {},
                                            iconSize: 14,
                                            highlightColor: Colors.transparent,
                                            splashColor: Colors.transparent,
                                            icon: Icon(Icons.add),
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

//customize logo button
                            Container(
                              height: 50,
                              width: 200,
                              margin: EdgeInsets.only(top: 12.0),
                              child: CustomWidgetButton(
                                onPressed: () {},
                                text: Strings.customizeWithLogo,
                              ),
                            ),

                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: Text(
                                Strings.description,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 22),
                              ),
                            ),

                            Container(
                              alignment: Alignment.center,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.4,
                              margin: EdgeInsets.only(top: 8.0),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: itemDescriptions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    children: [
                                      Bullets(),
                                      Container(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          itemDescriptions[index],
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
