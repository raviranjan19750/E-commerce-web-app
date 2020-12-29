import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/product_detail/product_detail_bloc.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/productVariantColorModel.dart';

class ProductVariantColorWidget extends StatefulWidget {
  final List<List<ProductVariantColor>> colorList;
  List<ProductVariantColor> initialSelectedColor;
  List<AllVariant> productAllVariant;
  String productID;
  String size;

  ProductVariantColorWidget(
      {Key key, this.colorList, this.initialSelectedColor,this.size, this.productID, this.productAllVariant})
      : super(key: key);

  @override
  _ProductVariantColorState createState() => _ProductVariantColorState();
}

class _ProductVariantColorState extends State<ProductVariantColorWidget> {
  int selectedColorCount;
  String variantID;
  List<ProductVariantColor> currentSelectedColor;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedColorCount = widget.initialSelectedColor.length;
    variantID = "";

    print("ColorOption: ${widget.colorList.toString()}");

    for(var x in widget.productAllVariant) {
      print("Variant Color : ${x.colour.toString()}");
    }

  }

  @override
  Widget build(BuildContext context) {


    void getOtherProductVariantID( List<ProductVariantColor> currentSelectedColor) {

      if(currentSelectedColor.length == 2) {

        for(int i = 0; i<currentSelectedColor.length; i++) {
          print("## + ${currentSelectedColor[i].colorHexCode.toString()}");
        }

        for(int i = 0; i<widget.productAllVariant.length; i++) {

          if(widget.productAllVariant[i].colour.length == 2) {

            //print("inside loop 12 ${widget.productAllVariant[i].colour[0]} , ${widget.productAllVariant[i].colour[1]}, ${widget.size}, ${widget.productAllVariant[i].size}");
            if(currentSelectedColor[0].colorHexCode == widget.productAllVariant[i].colour[0] && currentSelectedColor[1].colorHexCode == widget.productAllVariant[i].colour[1] ) {

              print("variantID1 : ${widget.productAllVariant[i].variantId}");
              variantID = widget.productAllVariant[i].variantId;
              break;

            }

          }

        }

      }
      else{

        for(int i = 0; i<currentSelectedColor.length; i++) {
          print("## : ${currentSelectedColor[i].colorHexCode.toString()}");
        }

        for(int i = 0; i<widget.productAllVariant.length; i++) {

          if(widget.productAllVariant[i].colour.length == 1) {

            if(currentSelectedColor[0].colorHexCode == widget.productAllVariant[i].colour[0] ) {

              print("variantID2 : ${widget.productAllVariant[i].variantId} ");
              variantID = widget.productAllVariant[i].variantId;
              break;

            }

          }

        }

      }


    }


    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.colorList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            setState(() {
              // widget.selectedVariantColor.add(widget.colorList[index]);


              currentSelectedColor = widget.colorList[index];

              if(currentSelectedColor.length == 2) {

                for(int i = 0; i<widget.productAllVariant.length; i++) {

                  if(widget.productAllVariant[i].colour.length == 2) {

                  //  print("inside loop 1 ${widget.productAllVariant[i].colour[0]} , ${widget.productAllVariant[i].colour[1]}, ${widget.size}, ${widget.productAllVariant[i].size}");
                    if(currentSelectedColor[0].colorHexCode == widget.productAllVariant[i].colour[0] &&
                        currentSelectedColor[1].colorHexCode == widget.productAllVariant[i].colour[1] &&
                        widget.size == widget.productAllVariant[i].size) {

                      print("variantID3 : ${widget.productAllVariant[i].variantId}");
                      variantID = widget.productAllVariant[i].variantId;
                      break;

                    }

                  }

                }

                 getOtherProductVariantID(currentSelectedColor);

              }else{

                for(int i = 0; i<currentSelectedColor.length; i++) {
                  print("## : ${currentSelectedColor[i].colorHexCode.toString()}");
                }

                for(int i = 0; i<widget.productAllVariant.length; i++) {

                  if(widget.productAllVariant[i].colour.length == 1) {

                    if(currentSelectedColor[0].colorHexCode == widget.productAllVariant[i].colour[0] && widget.size == widget.productAllVariant[i].size) {
                      print("variantID4 : ${widget.productAllVariant[i].variantId} ");
                      variantID = widget.productAllVariant[i].variantId;
                      break;

                    }

                  }

                }

                getOtherProductVariantID(currentSelectedColor);

              }


              print("productID: ${widget.productID},    variantID :  $variantID" );

              BlocProvider.of<ProductDetailBloc>(context).add(LoadProductDetail(widget.productID, variantID));
            });
          },
          child: widget.colorList[index].length == 2
              ? Container(
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.only(left: 6.0),
                  decoration: (widget.colorList[index].contains(widget.initialSelectedColor)) ? BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      width: 0.5,
                      color: Colors.black,
                    ),
                  ) : BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(8),
                            topLeft: Radius.circular(8),
                          ),
                          color: widget.colorList[index][0].colorHexCode,
                        ),
                        height: 8,
                        width: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          color: widget.colorList[index][1].colorHexCode,
                        ),
                        height: 8,
                        width: 16,
                      ),
                    ],
                  ),
                )
              : Container(
                  padding: EdgeInsets.all(4.0),
                  margin: EdgeInsets.only(left: 6.0),
                  decoration: (widget.colorList[index].contains(widget.initialSelectedColor)) ? BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(
                width: 0.5,
                color: Colors.black,
              ),
            ) : BoxDecoration(),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: widget.colorList[index][0].colorHexCode,
                  ),
                ),
        );
      },
    );
  }
}
