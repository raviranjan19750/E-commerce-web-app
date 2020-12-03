

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/models/product_type.dart';
import 'package:living_desire/models/product_variants.dart';
import 'package:living_desire/models/products.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailDescriptionsAndImage.dart';
import 'package:living_desire/screens/product_detail_screen.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/bullet.dart';
import 'package:living_desire/widgets/customButtonWidgets.dart';
import 'package:living_desire/widgets/home_screen_products/product_item.dart';
import 'package:living_desire/widgets/nextListHover.dart';
import 'package:living_desire/widgets/productTypeBar.dart';
import 'package:living_desire/widgets/wishListWidget.dart';

class ProductDetailScreen extends StatefulWidget {

  final Products products;
  final ProductVariants productVariants;

  const ProductDetailScreen({Key key, this.products, this.productVariants}) : super(key: key);

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final String productType = "Bean Bags";
    final List<Color> itemColor = itemColors;
    final List<String> itemDescriptions  = productItemDescriptions;
    final List<Product> products = product;
    final List<ProductType> productTypes = productsType;

    final double productListItemHeight = MediaQuery.of(context).size.height * 0.4;
    final double itemCardHeight =  MediaQuery.of(context).size.height * 0.20;
    final double descriptionWidth = MediaQuery.of(context).size.width*0.4;
    int itemQuantity = 0;
    bool increaseButtonHover = false;
    bool decreaseButtonHover = false;

    return Scaffold(

      appBar: CustomAppBar(),

      body: SingleChildScrollView(

        physics: ScrollPhysics(),

        child: Container(

          child: Column(
            children: [

              Container(

                margin: EdgeInsets.only(top:64.0),

                child: ProductDetailDescriptionAndImage(),
              ),

              Container(
                margin: EdgeInsets.only(top: 32.0, left: 32.0, right: 64.0),
                child: ProductTypeBar(
                  productType: productType,
                ),
              ),

              Container(
                  margin: EdgeInsets.only(top: 16.0),
                  height: productListItemHeight,
                  child:Stack(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItem(
                            product: products[index],
                          );
                        },
                      ),

                      Positioned(
                        right: 0,
                        top: itemCardHeight/2,
                        child: FlatButton(child: NextListHover()),
                      ),
                    ],
                  )
              ),

              Container(
                margin: EdgeInsets.only(top: 32.0, left: 32.0, right: 64.0),
                child: ProductTypeBar(
                  productType: productType,
                ),
              ),

              Container(
                  margin: EdgeInsets.only(top: 16.0),
                  height: productListItemHeight,
                  child:Stack(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItem(
                            product: products[index],
                          );
                        },
                      ),

                      Positioned(
                        right: 0,
                        top: itemCardHeight/2,
                        child: NextListHover(),
                      ),
                    ],
                  )
              ),

              Container(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );

    throw UnimplementedError();
  }
}


class ProductDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      // ignore: missing_return
        builder: (context,state) {

          if(state is ProductDetailLoading) {

            return CircularProgressIndicator();

          }else if (state is ProductDetailLoadingSuccessful) {

            return ProductDetailScreen(products: state.products, productVariants: state.productVariants,);

          }else {

            return Container();
          }

        }

    ) ;

  }

}



