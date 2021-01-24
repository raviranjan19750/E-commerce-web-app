import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/models/localNormalCart.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/screens/all_product/product_widgets.dart';
import 'package:living_desire/screens/login/login_view.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/customButtonWidgets.dart';

import '../../routes.dart';

class ProductDetailEnlargeImage extends StatefulWidget {
  final List<String> imageURL;
  String productID;
  String variantID;
  bool isInCart = false;
  Product product;
  int itemCount;

  ProductDetailEnlargeImage(
      {Key key,
      this.imageURL,
      this.productID,
      this.variantID,
      this.isInCart,
      this.product,
      this.itemCount})
      : super(key: key);

  @override
  _ProductDetailEnlargeImageState createState() =>
      _ProductDetailEnlargeImageState();
}

class _ProductDetailEnlargeImageState extends State<ProductDetailEnlargeImage> {
  int selectedImageIndex;
  String selectedURI;

  @override
  void initState() {
    selectedImageIndex = 0;
    selectedURI = widget.imageURL[0];
    super.initState();
  }

  void _showLoginDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoginScreen();
        });
  }

  bool isInCart = false;

  @override
  Widget build(BuildContext context) {
    ScrollController imageListScrollController = new ScrollController();

    double imageWidth = MediaQuery.of(context).size.width * 0.26;
    double imageHeight = MediaQuery.of(context).size.height * 0.62;

    double imageListWidth = MediaQuery.of(context).size.width * 0.06;
    double imageListHeight = MediaQuery.of(context).size.height * 0.55;

    moveUP() {
      imageListScrollController.animateTo(
          imageListScrollController.offset + imageListHeight,
          curve: Curves.linear,
          duration: Duration(milliseconds: 400));
    }

    moveDown() {
      imageListScrollController.animateTo(
          imageListScrollController.offset - imageListHeight,
          curve: Curves.linear,
          duration: Duration(milliseconds: 400));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //List of images
        Container(
          margin: EdgeInsets.only(left: 32.0),
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: moveUP,
                alignment: Alignment.center,
                icon: Icon(Icons.keyboard_arrow_up),
                color: Colors.black,

              ),

              SizedBox(height: 16,),

              Container(
                width: imageListWidth,
                //height: imageListHeight,
                margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
                color: Palette.lightGrey,
                alignment: Alignment.center,
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: imageListScrollController,
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

              SizedBox(height: 16,),

              IconButton(

                onPressed: moveDown,
                icon: Icon(Icons.keyboard_arrow_down),
                color: Colors.black,

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
                      child: ProductWishlistButton(
                        productId: widget.productID,
                        varientId: widget.variantID,
                      ),
                    ),
                  ],
                ),
              ),

// action buttons

              Container(
                width: imageWidth,
                height: 50,
                margin: EdgeInsets.only(left: 0.0, top: 8.0),
                child: Row(
                  children: [
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                      switch (state.status) {
                        case AuthenticationStatus.authenticated:
                          return Expanded(
                            flex: 1,
                            child: Container(
                              height: double.infinity,
                              child: CustomWidgetButton(
                                onPressed: () {

                                  setState(() {

                                    if(isInCart || widget.isInCart) {
                                      locator<NavigationService>()
                                          .navigateTo(RoutesConfiguration.CART);
                                    }
                                   else {

                                      BlocProvider.of<CartBloc>(context)
                                          .add(AddCart(
                                        authID: state.user.uid,
                                        productID: widget.productID,
                                        variantID: widget.variantID,
                                        quantity: widget.itemCount,
                                      ));

                                      SnackBar snackBar = SnackBar(
                                        content: Text(Strings.itemAddedInCart,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(color: Colors.white)),
                                        backgroundColor: Palette.maroon,
                                        duration: Duration(seconds: 2),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);


                                    }
                                    isInCart = true;

                                  });
                                },
                                text: (isInCart|| widget.isInCart)
                                    ? Strings.goToCart
                                    : Strings.addToCart,
                              ),
                            ),
                          );
                        // Your Code HERE(Get AuthID from state.user.uid)
                        case AuthenticationStatus.unauthenticated:
                          return Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(right: 0.0),
                              child: Container(
                                height: double.infinity,
                                child: CustomWidgetButton(
                                  onPressed: () {

                                    setState(() {

                                      if(isInCart || widget.isInCart) {
                                        locator<NavigationService>()
                                            .navigateTo(RoutesConfiguration.CART);
                                      }else{
                                        BlocProvider.of<CartBloc>(context)
                                            .add(AddCart(
                                          authID: null,
                                          productID: widget.productID,
                                          variantID: widget.variantID,
                                          quantity: widget.itemCount,
                                        ));

                                        final snackBar = SnackBar(
                                          content: Text(Strings.itemAddedInCart,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.white)),
                                          backgroundColor: Palette.maroon,
                                          duration: Duration(seconds: 2),
                                        );
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                                      }

                                      isInCart = true;


                                    });


                                  },
                                  text: (isInCart || widget.isInCart)
                                      ? Strings.goToCart
                                      : Strings.addToCart,
                                ),
                              ),
                            ),
                          );
                        default:
                          return Expanded(
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
                          );
                      }
                    }),
//add to cart button

                    SizedBox(
                      width: 10,
                    ),
// buy now button
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                      switch (state.status) {
                        case AuthenticationStatus.authenticated:
                          return Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(right: 0.0),
                              child: Container(
                                height: double.infinity,
                                child: CustomWidgetButton(
                                  onPressed: () {
                                    // send data
                                    BlocProvider.of<CartBloc>(context)
                                        .add(AddCart(
                                      authID: state.user.uid,
                                      productID: widget.productID,
                                      variantID: widget.variantID,
                                      quantity: widget.itemCount,
                                    ));

                                    locator<NavigationService>().navigateTo(
                                        RoutesConfiguration.SELECT_ADDRESS,
                                        queryParams: {
                                          "productID": widget.productID,
                                          "variantID": widget.variantID,
                                          "isBuyNow": "true"
                                        });
                                  },
                                  backGroundColor: Colors.black,
                                  textColor: Colors.white,
                                  text: Strings.buyNow,
                                ),
                              ),
                            ),
                          );
                        // Your Code HERE(Get AuthID from state.user.uid)
                        case AuthenticationStatus.unauthenticated:
                          return Expanded(
                            flex: 1,
                            child: Container(
                              padding: EdgeInsets.only(right: 0.0),
                              child: Container(
                                height: double.infinity,
                                child: CustomWidgetButton(
                                  onPressed: () {
                                    _showLoginDialog(context);
                                  },
                                  backGroundColor: Colors.black,
                                  textColor: Colors.white,
                                  text: Strings.buyNow,
                                ),
                              ),
                            ),
                          );
                        default:
                          return Expanded(
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
                          );
                      }
                    })
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
