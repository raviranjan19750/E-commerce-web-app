import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/productVariantColorModel.dart';
import 'package:living_desire/service/navigation_service.dart';

import '../../main.dart';
import '../../routes.dart';

class ProductVariantSizeList extends StatelessWidget {
  List<String> sizeOptionsList;
  List<ProductVariantColor> selectedColor;
  List<AllVariant> allVariantList;
  String productID;
  String variantSize;

  ProductVariantSizeList(
      {Key key,
      this.sizeOptionsList,
      this.productID,
      this.variantSize,
      this.selectedColor,
      this.allVariantList})
      : super(key: key);

  String variantID;
  List<String> availableVariantSizeList = new List();
  double opacityValue = 0.2;
  String selectedSizeValue;

  bool colorsAreEqual(
      List<Color> variantColor, List<ProductVariantColor> selectedColor) {
    if (selectedColor.length == 2) {
      if (variantColor.elementAt(0) ==
              selectedColor.elementAt(0).colorHexCode &&
          variantColor.elementAt(1) ==
              selectedColor.elementAt(1).colorHexCode) {
        return true;
      }
    } else {
      if (variantColor.elementAt(0) ==
          selectedColor.elementAt(0).colorHexCode) {
        return true;
      }
    }

    return false;
  }

  bool isVariantSizeAvailable(
      List<String> availableVariantSizeList, String size) {
    if (availableVariantSizeList.contains(size)) return true;

    return false;
  }

  List<String> getSizeList(List<AllVariant> allVariantList,
      List<ProductVariantColor> selectedColor) {
    for (var variantValue in allVariantList) {
      if (variantValue.colour.length == selectedColor.length) {
        if (colorsAreEqual(variantValue.colour, selectedColor)) {
          availableVariantSizeList.add(variantValue.size);
        }
      }
    }

    return availableVariantSizeList;
  }

  String getVariantID(List<AllVariant> allVariantList,
      List<ProductVariantColor> selectedColor, String selectedSize) {
    for (var variantValue in allVariantList) {
      if (variantValue.colour.length == selectedColor.length) {
        if (colorsAreEqual(variantValue.colour, selectedColor) &&
            variantValue.size == selectedSize) {
          return variantValue.variantId;
        }
      }
    }

    return "";
  }

  BoxDecoration selectedBoxDecoration(String initialSize, String givenSize) {
    if (givenSize == initialSize) {
      return BoxDecoration(
          border: Border.all(color: Colors.orange, width: 1.0),
          borderRadius: BorderRadius.circular(2.0));
    }
    return BoxDecoration(
        border: Border.all(color: Colors.black.withOpacity(0.7), width: 1.0),
        borderRadius: BorderRadius.circular(2.0));
  }

  TextStyle selectedSizeText(String initialSize, String givenSize) {
    if (givenSize == initialSize) {
      return TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.orange);
    }

    return TextStyle(fontSize: 16.0, color: Colors.black.withOpacity(0.7));
  }

  @override
  Widget build(BuildContext context) {
    availableVariantSizeList = getSizeList(allVariantList, selectedColor);

    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: sizeOptionsList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(right: 12.0),
            child: InkWell(
              onTap: () {
                selectedSizeValue = sizeOptionsList[index];

                if (selectedSizeValue != variantSize) {
                  if (isVariantSizeAvailable(
                      availableVariantSizeList, selectedSizeValue)) {
                    variantID = getVariantID(
                        allVariantList, selectedColor, selectedSizeValue);

                    locator<NavigationService>().navigateTo(
                      RoutesConfiguration.PRODUCT_DETAIL,
                      queryParams: {
                        "pid": productID,
                        "vid": variantID,
                      },
                    );
                  } else {
                    SnackBar snackBar = SnackBar(
                      content: Text(Strings.currentlyProductNotAvailable,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.yellow)),
                      backgroundColor: Colors.black,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              child: (isVariantSizeAvailable(
                      availableVariantSizeList, sizeOptionsList[index]))
                  ? Container(
                      width: 55,
                      alignment: Alignment.center,
                      decoration: selectedBoxDecoration(
                          variantSize, sizeOptionsList[index]),
                      //             <--- BoxDecoration here
                      child: Text(
                        sizeOptionsList[index].toUpperCase(),
                        style: selectedSizeText(
                            variantSize, sizeOptionsList[index]),
                      ),
                    )
                  : Container(
                      width: 55,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          color: Colors.white.withOpacity(opacityValue)),
                      //             <--- BoxDecoration here
                      child: Text(
                        sizeOptionsList[index].toUpperCase(),
                        style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black.withOpacity(opacityValue)),
                      ),
                    ),
            ),
          );
        });
  }
}
