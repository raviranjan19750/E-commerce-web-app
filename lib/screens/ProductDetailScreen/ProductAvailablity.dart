import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:living_desire/DBHandler/ProductRepository.dart';
import 'package:living_desire/bloc/product_availability_bloc.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';

class ProductAvailability extends StatelessWidget {
  final String productID;
  final String variantID;

  const ProductAvailability({Key key, this.productID, this.variantID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ProductAvailabilityBloc(
                productRepository: RepositoryProvider.of(context))
              ..add(CheckingProductAvailabilityInitial()),
          ),
        ],
        child: ProductAvailabilitySection(
          productID: productID,
          variantID: variantID,
        ));
  }
}

class ProductAvailabilitySection extends StatelessWidget {
  final String productID;
  final String variantID;

  const ProductAvailabilitySection({Key key, this.productID, this.variantID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pincode;

    TextEditingController textEditingController;

    textEditingController = TextEditingController();

    pincode = "";

    return Column(
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
              width: 130,
              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
              child: TextFormField(
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (val) {
                    pincode = val;
                  },
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      labelText: Strings.checkAvailability,
                      border: InputBorder.none,
                      labelStyle: TextStyle(color: Colors.black54),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      counterText: "")),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<ProductAvailabilityBloc>(context).add(
                    CheckingProductAvailability(productID, variantID, pincode));
              },
              child: Text(
                Strings.check,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            )
          ],
        ),
        Container(
          width: 230,
          padding: EdgeInsets.all(0.0),
          margin: EdgeInsets.all(0.0),
          child: Divider(
            thickness: 1.0,
            height: 0.0,
            color: Colors.black,
          ),
        ),
        BlocBuilder<ProductAvailabilityBloc, ProductAvailabilityState>(
          builder: (context, state) {
            if (state is ProductDetailAvailabilityChecking)
              return Padding(
                  padding: EdgeInsets.all(4.0),
                  child: CircularProgressIndicator(
                      strokeWidth: 3.0,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.black,
                      )));
            else if (state is ProductDetailAvailabilityCheckingSuccessful)
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (state.checkProductAvailability.responseCode == 200)
                    Text(
                      Strings.available.toUpperCase() +
                          " (Delivery by " + DateFormat('dd MMM, EEEE').format(state.checkProductAvailability.expectedDeliveryDate) + " )",
                      style: TextStyle(
                          color: Palette.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    )
                  else if (state.checkProductAvailability.responseCode == 402)
                    Text(
                      Strings.notAvailable.toUpperCase(),
                      style: TextStyle(
                          color: Colors.red[500],
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    )
                  else
                    Text(
                      Strings.invalidPincode.toUpperCase(),
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                ],
              );
            else if (state is ProductDetailAvailabilityCheckingFailure)
              return Container(
                child: Text(
                  "Not available",
                ),
              );
            else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
