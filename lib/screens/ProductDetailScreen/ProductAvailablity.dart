
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/DBHandler/ProductRepository.dart';
import 'package:living_desire/bloc/product_availability_bloc.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';

class ProductAvailability extends StatelessWidget {

  final String productID;
  final String wareHouseID;

  const ProductAvailability({Key key, this.productID, this.wareHouseID}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => ProductAvailabilityBloc(
            productRepository: RepositoryProvider.of(context))..add(CheckingProductAvailabilityInitial()),
      ),

    ], child: ProductAvailabilitySection());
  }


}



class ProductAvailabilitySection extends StatelessWidget {

  @override
  Widget build(BuildContext context) {


    ProductRepository productRepository;
    var checkProductAvailability;
    DateTime expectedDeliveryDate;
    String availabilityResponseStatus ;
    String pincode;
    String pincodeInvalidMessage;
    TextEditingController textEditingController;

    pincodeInvalidMessage = Strings.invalidPincode;
    textEditingController = TextEditingController();
    availabilityResponseStatus = "0";
    pincode = "";
    expectedDeliveryDate = DateTime.now();


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
              width: 120,
              margin: EdgeInsets.symmetric(
                  horizontal: 8.0, vertical: 0.0),
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
                      labelStyle: TextStyle(
                          color: Colors.black54),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      counterText: "")),
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<ProductAvailabilityBloc>(context).add(CheckingProductAvailability("0IeSrbsqqxiqwELq4Qqm", "temp_id", "110062"));
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
          width: 220,
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
            if(state is ProductDetailAvailabilityChecking)
              return CircularProgressIndicator();
            else if (state is ProductDetailAvailabilityCheckingSuccessful)
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  if(state.checkProductAvailability.responseCode == 200)
                    Text(
                      Strings.available.toUpperCase(),
                      style: TextStyle(
                          color: Palette.green,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    )
                  else if(state.checkProductAvailability.responseCode == 402)
                    Text(
                      Strings.notAvailable.toUpperCase() ,
                      style: TextStyle(
                          color: Colors.red[500],
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    )
                  else
                    Text(
                      Strings.available.toUpperCase(),
                      style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                ],
              );
            else if (state is ProductDetailAvailabilityCheckingFailure)
              return Container(
                child: Text(
                  "Not avaiable",
                ),
              );
            else{
              return Container();
            }
          },

        ),



      ],
    );
  }
}
