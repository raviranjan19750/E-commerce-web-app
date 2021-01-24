import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';

import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/bulk_order/step_one_block.dart';
import 'package:living_desire/screens/bulk_order/step_three_block.dart';
import 'package:living_desire/screens/bulk_order/step_two_block.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/footer/footer.dart';
import 'package:provider/provider.dart';

import 'bulk_order_cart.dart';

class BulkOrder extends StatelessWidget {
  final String productType, productSubType, size, productID, variantID,color;

  BulkOrder(
      {this.productID,
      this.variantID,
      this.productType,
      this.productSubType,
      this.color,
      this.size});

  bool init = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => BulkOrderProvider(),
        child: Consumer<BulkOrderProvider>(
          builder:
              (BuildContext context, BulkOrderProvider value, Widget child) {
            if (!init) {
              Provider.of<BulkOrderProvider>(context, listen: false)
                  .initStepOne(
                      productID, variantID, size, productType, productSubType,color);
              init = true;
            }

            return Scaffold(
              appBar: CustomAppBar(
                visibleSubAppBar: false,
                visibleMiddleAppBar: false,
              ),
              body: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 32, right: 32),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Order in Bulk',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            StepOneBlock(
                              productType: productType,
                              productSubType: productSubType,
                              value: value,
                            ),
                            StepTwoBlock(
                              value: value,
                            ),
                            StepThreeBlock(
                              value: value,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 16, bottom: 64),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Palette.secondaryColor),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  child: FlatButton(
                                    padding: EdgeInsets.only(
                                        left: 80,
                                        right: 80,
                                        top: 28,
                                        bottom: 28),
                                    onPressed: () {
                                      value.onClear();
                                    },
                                    color: Colors.white,
                                    child: Text(
                                      'Clear',
                                      style: TextStyle(
                                          color: Palette.secondaryColor,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible:
                                      value.stepOneDone && value.stepTwoDone,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: 16, left: 32, bottom: 64),
                                    alignment: Alignment.centerLeft,
                                    child: RaisedButton(
                                      padding: EdgeInsets.only(
                                          left: 80,
                                          right: 80,
                                          top: 28,
                                          bottom: 28),
                                      onPressed: () {
                                        if (value.editElementIndex == -1)
                                          value.showProgressDialog(
                                              context, "Adding to cart");
                                        else
                                          value.showProgressDialog(
                                              context, "Updating cart");

                                        value.addToCart();
                                      },
                                      color: Palette.secondaryColor,
                                      child: Text(
                                        value.buttonName,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                      height: double.infinity,
                      child: BulkOrderCart(
                        value: value,
                      ))
                ],
              ),
            );
          },
        ));
  }
}
