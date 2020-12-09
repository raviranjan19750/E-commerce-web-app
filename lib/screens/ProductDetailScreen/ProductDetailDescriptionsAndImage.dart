import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/StringToHexColor.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailEnlargeImage.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/ProductCountWidget.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/ProductSizeDropdownWidget.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/customButtonWidgets.dart';
import 'package:living_desire/widgets/bullet.dart';

import 'package:living_desire/widgets/wishListWidget.dart';

class ProductDetailDescriptionAndImage extends StatelessWidget {

  final List<Color> itemColor = itemColors;
  final List<String> itemDescriptions = productItemDescriptions;

  @override
  Widget build(BuildContext context) {

    double imageWidth = MediaQuery.of(context).size.width * 0.26;
    double imageHeight = MediaQuery.of(context).size.height * 0.62;

    double imageListWidth = MediaQuery.of(context).size.width*0.06;
    double imageListHeight = MediaQuery.of(context).size.height*0.55;

    int selectedImageIndex = 0;

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
               ProductDetailEnlargeImage(imageURL: state.productDetail.images),

                // description of product
                Container(
                  margin: EdgeInsets.only(left: 32.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          state.productDetail.productName,
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: Text(
                          "₹ " + state.productDetail.sellingPrice.toString(),
                          style: TextStyle(
                              color: Colors.grey[400],
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        child: Text(
                          "₹ " + state.productDetail.discountPrice.toString(),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 22),
                        ),
                      ),
                      Container(
                        child: Text(
                          "You save ₹ " + (state.productDetail.sellingPrice-state.productDetail.discountPrice).toString(),
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
                                  Container(

                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    height: 40,
                                    padding: EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      children: [

                                        Container(

                                          child: Text(
                                            Strings.size + ": ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        ),

                                        ProductSizeDropdown()
                                      ],
                                    ),
                                  ),

                                  SizedBox(width: 12),

                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5,
                                        )),
                                    child: Row(
                                      children: [
                                       ProductQuantityCount(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

//customize logo button
                            state.productDetail.isCustomizable? Container(
                              height: 45,
                              width: 220,
                              margin: EdgeInsets.only(top: 12.0),
                              child: CustomWidgetButton(
                                onPressed: () {},
                                text: Strings.customizeWithLogo,
                              ),
                            ) : Container(
                              height: 45,
                              width: 220,
                              color: Colors.brown,
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
                                itemCount: state.productDetail.description.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Bullets(),
                                      Container(
                                        width: 10,
                                      ),
                                      Flexible(
                                        child: Text(
                                          state.productDetail.description[index],
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
