import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/product_card/product_card_bloc.dart';

import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/customButtonWidgets.dart';

class ProductDetailEnlargeImage extends StatefulWidget {
  final List<String> imageURL;
  String productID;
  String variantID;

  ProductDetailEnlargeImage({
    Key key,
    this.imageURL,
    this.productID,
    this.variantID,
  }) : super(key: key);

  @override
  _ProductDetailEnlargeImageState createState() =>
      _ProductDetailEnlargeImageState();
}

class _ProductDetailEnlargeImageState extends State<ProductDetailEnlargeImage> {
  int selectedImageIndex;
  int selectedColorIndex;
  int selectedSizeIndex;
  String selectedURI;

  @override
  void initState() {
    selectedImageIndex = 0;
    selectedURI = widget.imageURL[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * 0.26;
    double imageHeight = MediaQuery.of(context).size.height * 0.62;

    double imageListWidth = MediaQuery.of(context).size.width * 0.06;
    double imageListHeight = MediaQuery.of(context).size.height * 0.55;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //List of images
        Container(
          margin: EdgeInsets.only(left: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: imageListWidth,
                height: 30,
                color: Palette.lightGrey,
                child: IconButton(
                  onPressed: () {},
                  alignment: Alignment.center,
                  icon: Icon(Icons.keyboard_arrow_up),
                  color: Colors.black,
                ),
              ),
              Container(
                width: imageListWidth,
                //height: imageListHeight,
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
                color: Palette.lightGrey,
                alignment: Alignment.center,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.imageURL.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedImageIndex = index;
                          selectedURI =
                              widget.imageURL[selectedImageIndex].toString();
                        });
                      },
                      child: Container(
                        child: (widget.imageURL[index] != null)
                            ? Image.network(widget.imageURL[index].toString())
                            : Text(
                                widget.imageURL[index],
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: imageListWidth,
                height: 30,
                color: Palette.lightGrey,
                child: IconButton(
                  onPressed: () {},
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

              InkWell(
                child: Container(
                  height: imageHeight,
                  width: imageWidth,
                  decoration: new BoxDecoration(
                      //color: Palette.lightGrey,
                      image: DecorationImage(
                    fit: BoxFit.fill,
                    image: (selectedURI != null)
                        ? NetworkImage(selectedURI)
                        : NetworkImage(widget.imageURL[0]),
                  )),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Icon(Icons.favorite),
                      ),
                    ],
                  ),
                ),
              ),

// action buttons
              Container(
                width: imageWidth,
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
                          onPressed: () {
                            final _cartlist =
                                Hive.box<Map<String, String>>('cart_items');
                            _cartlist.put(widget.variantID, {
                              "productID": widget.productID,
                              "variantID": widget.variantID
                            });

                            BlocProvider.of<CartBloc>(context).add(AddCart(
                              authID: "id1",
                              productID: widget.productID,
                              variantID: widget.variantID,
                              quantity: 1,
                            ));

                            // BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                            //   if (state is CartDetailLoading) {
                            //     return CircularProgressIndicator();
                            //   } else if (state is CartDetailLoadingSuccessful) {
                            //     return SnackBar(
                            //       content: Text('Item added to cart'),
                            //     );
                            //   }
                            // });
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
      ],
    );
  }
}
