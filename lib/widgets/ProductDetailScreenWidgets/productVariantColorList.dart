import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/productVariantColorModel.dart';
import 'package:living_desire/service/navigation_service.dart';

import '../../main.dart';
import '../../routes.dart';

// ignore: must_be_immutable
class ProductVariantColorWidget extends StatefulWidget {
  final List<List<ProductVariantColor>> colorList;
  List<ProductVariantColor> initialSelectedColor;
  List<AllVariant> productAllVariant;
  String productID;
  String size;
  String authID;

  ProductVariantColorWidget(
      {Key key,
      this.colorList,
      this.initialSelectedColor,
      this.size,
      this.productID,
      this.authID,
      this.productAllVariant})
      : super(key: key);

  @override
  _ProductVariantColorState createState() => _ProductVariantColorState();
}

class _ProductVariantColorState extends State<ProductVariantColorWidget> {
  int selectedColorCount;
  String variantID;
  List<ProductVariantColor> currentSelectedColor;
  List<List<Color>> availableVariantColorList = new List();
  double opacityValue = 0.2;

  @override
  void initState() {
    super.initState();
    selectedColorCount = widget.initialSelectedColor.length;
    variantID = "";
    getAvailableVariantColorList(widget.productAllVariant, widget.size);
  }

  void getAvailableVariantColorList(List<AllVariant> productAllVariant, String size) {
    for (var val in productAllVariant) {
      if (val.size == size) {
        availableVariantColorList.add(val.colour);
      }
    }
  }

  bool isVariantColorAvailable(List<List<Color>> availableVariantColorList, List<ProductVariantColor> colorList) {
    for (int i = 0; i < availableVariantColorList.length; i++) {
      if (availableVariantColorList.elementAt(i).length == colorList.length) {
        if (colorList.length == 2) {
          if (availableVariantColorList[i][0] == colorList[0].colorHexCode &&
              availableVariantColorList[i][1] == colorList[1].colorHexCode) {
            return true;
          }
        }

        if (colorList.length == 1) {
          if (availableVariantColorList[i][0] == colorList[0].colorHexCode) {
            return true;
          }
        }
      }
    }

    return false;
  }

  bool colorCompare(List<ProductVariantColor> selectedColor, List<ProductVariantColor> initialSelectedColor) {
    if (selectedColor.length != initialSelectedColor.length) {
      return false;
    }

    for (int i = 0; i < initialSelectedColor.length; i++) {
      if (i < selectedColor.length) {
        if (initialSelectedColor.elementAt(i).colorHexCode !=
            selectedColor.elementAt(i).colorHexCode) {
          return false;
        }
      } else {
        return false;
      }
    }

    return true;
  }

  BoxDecoration compareColor(List<ProductVariantColor> colorList, List<ProductVariantColor> initialSelectedColor) {
    if (colorList.length != initialSelectedColor.length) {
      return BoxDecoration();
    }

    for (int i = 0; i < initialSelectedColor.length; i++) {
      if (i < colorList.length) {
        if (initialSelectedColor.elementAt(i).colorHexCode !=
            colorList.elementAt(i).colorHexCode) {
          return BoxDecoration();
        }
      } else {
        return BoxDecoration();
      }
    }

    return BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.white,
      border: Border.all(
        width: 0.5,
        color: Colors.black,
      ),
    );
  }

  String getOtherProductVariantID(List<ProductVariantColor> currentSelectedColor) {
    if (currentSelectedColor.length == 2) {
      for (int i = 0; i < widget.productAllVariant.length; i++) {
        if (widget.productAllVariant[i].colour.length == 2) {
          if (currentSelectedColor[0].colorHexCode ==
                  widget.productAllVariant[i].colour[0] &&
              currentSelectedColor[1].colorHexCode ==
                  widget.productAllVariant[i].colour[1]) {
            return widget.productAllVariant[i].variantId;
          }
        }
      }
    } else {
      for (int i = 0; i < widget.productAllVariant.length; i++) {
        if (widget.productAllVariant[i].colour.length == 1) {
          if (currentSelectedColor[0].colorHexCode ==
              widget.productAllVariant[i].colour[0]) {
            return widget.productAllVariant[i].variantId;
          }
        }
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: widget.colorList.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {

        return InkWell(
          onTap: () {
            setState(() {
              if (isVariantColorAvailable(availableVariantColorList, widget.colorList[index])) {
                currentSelectedColor = widget.colorList[index];

                if (!(colorCompare(
                    currentSelectedColor, widget.initialSelectedColor))) {
                  if (currentSelectedColor.length == 2) {
                    for (int i = 0; i < widget.productAllVariant.length; i++) {
                      if (widget.productAllVariant[i].colour.length == 2) {
                        if (currentSelectedColor[0].colorHexCode ==
                                widget.productAllVariant[i].colour[0] &&
                            currentSelectedColor[1].colorHexCode ==
                                widget.productAllVariant[i].colour[1] &&
                            widget.size == widget.productAllVariant[i].size) {
                          variantID = widget.productAllVariant[i].variantId;
                          break;
                        }
                      }
                    }

                    variantID = getOtherProductVariantID(currentSelectedColor);
                  } else {
                    for (int i = 0; i < widget.productAllVariant.length; i++) {
                      if (widget.productAllVariant[i].colour.length == 1) {
                        if (currentSelectedColor[0].colorHexCode ==
                                widget.productAllVariant[i].colour[0] &&
                            widget.size == widget.productAllVariant[i].size) {
                          variantID = widget.productAllVariant[i].variantId;
                          break;
                        }
                      }
                    }

                    variantID = getOtherProductVariantID(currentSelectedColor);
                  }

                  locator<NavigationService>().navigateTo(
                    RoutesConfiguration.PRODUCT_DETAIL,
                    queryParams: {
                      "pid": widget.productID,
                      "vid": variantID,
                    },
                  );
                }
              }
              else {
                final snackBar = SnackBar(
                  content: Text(Strings.currentlyProductNotAvailable,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.yellow)),
                  backgroundColor: Colors.black,
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            });
          },
          child: widget.colorList[index].length == 2
              ? Container(
                  child: Container(
                    padding: EdgeInsets.all(4.0),
                    margin: EdgeInsets.only(left: 3.0, right: 3.0),
                    decoration: compareColor(
                        widget.colorList[index], widget.initialSelectedColor),
                    child: (isVariantColorAvailable(
                            availableVariantColorList, widget.colorList[index]))
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8),
                                  ),
                                  color: widget.colorList[index][0].colorHexCode
                                      .withOpacity(1.0),
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
                                  color: widget.colorList[index][1].colorHexCode
                                      .withOpacity(1.0),
                                ),
                                height: 8,
                                width: 16,
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    topLeft: Radius.circular(8),
                                  ),
                                  color: widget.colorList[index][0].colorHexCode
                                      .withOpacity(opacityValue),
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
                                  color: widget.colorList[index][1].colorHexCode
                                      .withOpacity(opacityValue),
                                ),
                                height: 8,
                                width: 16,
                              ),
                            ],
                          ),
                  ),
                )
              : Container(
                  child: (isVariantColorAvailable(
                          availableVariantColorList, widget.colorList[index]))
                      ? Container(
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            margin: EdgeInsets.only(left: 3.0, right: 3.0),
                            decoration: compareColor(widget.colorList[index],
                                widget.initialSelectedColor),
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: widget
                                  .colorList[index][0].colorHexCode
                                  .withOpacity(1.0),
                            ),
                          ),
                        )
                      : Container(
                          child: Container(
                            padding: EdgeInsets.all(4.0),
                            margin: EdgeInsets.only(left: 3.0, right: 3.0),
                            decoration: compareColor(widget.colorList[index],
                                widget.initialSelectedColor),
                            child: CircleAvatar(
                              radius: 8,
                              backgroundColor: widget
                                  .colorList[index][0].colorHexCode
                                  .withOpacity(opacityValue),
                            ),
                          ),
                        ),
                ),
        );
      },
    );
  }
}
