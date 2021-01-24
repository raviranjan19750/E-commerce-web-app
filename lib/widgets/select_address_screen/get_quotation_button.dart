import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/select_address/select_address_bloc.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/configs.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/service/navigation_service.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../main.dart';
import '../../routes.dart';

class GetQuotationButton extends StatelessWidget {
  final String authID;
  final bool isSampleRequested;
  final String deliveryAddressID;

  const GetQuotationButton(
      {Key key, this.authID, this.isSampleRequested, this.deliveryAddressID})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String orderKey;
    var orderData;
    var LOG = Logger();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          try {
            var data = {
              "isSampleRequested": isSampleRequested,
              "deliveryAddressID": deliveryAddressID
            };
            print(isSampleRequested);
            print(deliveryAddressID);
            final response = await CloudFunctionConfig.post(
                'manageCustomOrder/custom-request/$authID', data);

            if (response.statusCode == 200) {
              LOG.i(response.body);
              orderData = (jsonDecode(response.body));
              orderKey = orderData["key"];
              LOG.i(orderKey);
              locator<NavigationService>().navigateTo(
                  RoutesConfiguration.BULK_ORDER_QUOTATION,
                  queryParams: {
                    "key": orderKey,
                  });
            } else {
              LOG.i(response.statusCode);
            }
          } catch (exception, stackTrace) {
            await Sentry.captureException(exception, stackTrace: stackTrace);

            return exception;
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Palette.secondaryColor,
          ),

          // Get Quotation

          child: Center(
            child: Text(
              Strings.getQuotation,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
