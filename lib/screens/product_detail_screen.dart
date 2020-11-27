import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/provider_models/ProductDetailModel.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/customButtonWidgets.dart';
import 'package:living_desire/widgets/wishListWidget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductDetailScreen extends StatelessWidget {
  bool init = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => ProductDetailModel(),
      child: Consumer<ProductDetailModel>(
          // ignore: missing_return
          builder: (BuildContext context, ProductDetailModel productDetail,
              Widget child) {
        if (!init) {
          Provider.of<ProductDetailModel>(context, listen: false).getAuthID();
          init = true;
        }

        return ProductDetailStatelessScreen(productDetail: productDetail);
      }),
    );
  }
}

class ProductDetailStatelessScreen extends StatelessWidget {
  final ProductDetailModel productDetail;

  const ProductDetailStatelessScreen({Key key, this.productDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final List<Color> itemColor = itemColors;
    final List<String> itemDescriptions  = productItemDescriptions;

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
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: 30,
                        color: Palette.lightGrey,
                        child: IconButton(
                          alignment: Alignment.center,
                          icon: Icon(Icons.keyboard_arrow_up),
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: MediaQuery.of(context).size.height * 0.45,
                        margin: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 0.0),
                        color: Palette.lightGrey,
                        alignment: Alignment.center,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.06,
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
                        height: MediaQuery.of(context).size.height * 0.45,
                        width: MediaQuery.of(context).size.width * 0.2,
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
                                child: CircleAvatar(
                                    child: ProductWishlistButton()
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // action buttons
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
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

                  // description of product
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Classic Filled Bean Bags",
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Rs 2000",
                          style: TextStyle(
                              color: Palette.green,
                              decoration: TextDecoration.lineThrough,
                              fontSize: 14),
                        ),
                      ),
                      Container(
                        child: Text(
                          "Rs 2000",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Container(
                        child: Text(
                          "You save Rs 50",
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ),
                      Container(
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
                                  width: 150,
                                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),

                                  child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      maxLength: 6,
                                      onChanged: (val) {},
                                      decoration: InputDecoration(
                                        labelText: 'Check Availability',
                                        focusColor: Colors.grey,
                                        hoverColor: Colors.grey,
                                        fillColor: Colors.grey,
                                        border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                        counterText: ""
                                      )),
                                ),

                                Text(
                                  Strings.check,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,

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
                                height: 1.0,
                                color: Colors.black,
                              ),
                            ),

                            Text(
                              Strings.available.toUpperCase(),
                              style: TextStyle(
                                color: Palette.green,
                                fontWeight: FontWeight.normal,
                                fontSize: 14
                              ),
                            ),

                            //list of color
                            //todo Set lst of color
                            Container(
                              //width: 150,
                              height: 50,

                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: itemColor.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext context, int index){
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
                                          width: 0.5,
                                          color: Colors.black
                                        )
                                      ),
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: itemColor[index],
                                      ),
                                    ),
                                  );

                                },
                              ),
                            ),

                            // setting size and quantity buttonn
                            Row(),

                            //customize logo button
                            CustomWidgetButton(
                              onPressed: () {},
                              text: Strings.customizeWithLogo,
                            ),

                            Text(
                              Strings.description,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 22
                              ),
                            ),

                            Container(
                              alignment: Alignment.center,

                              height: 300,
                              width: 500,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: itemDescriptions.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    minLeadingWidth: 0.0,
                                    minVerticalPadding: 0.0,
                                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                                    leading: MyBullet(),

                                    title: Text(
                                      itemDescriptions[index],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16,
                                      ),
                                    ),


                                  );
                                },
                              ),
                            )
                          ],
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

class MyBullet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(0.0),
      height: 8.0,
      width: 8.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}
