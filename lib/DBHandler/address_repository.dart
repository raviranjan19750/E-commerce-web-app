import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

class AddressRepository {
  // Get Address Details
  var LOG = LogBuilder.getLogger();

  List<Address> _addresses = List.empty();

  List<Address> get addresses => _addresses;

  Future<List<Address>> getAddressDetails(String authID) async {
    try {
      final response =
          await CloudFunctionConfig.get('manageAddress/list/${authID}');

      LOG.i("Http Get request address Container");
      if (response.statusCode == 200) {
        _addresses = (jsonDecode(response.body) as List)
            .map((i) => Address.fromJson(i))
            .toList();
        return _addresses;
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  // Add Address Details
  Future<void> addAddressDetails(
    String authID,
    String address,
    String pincode,
    String phone,
    String name,
  ) async {
    try {
      var params = {
        "address": address,
        "pincode": pincode,
        "phone": phone,
        "name": name,
      };

      await CloudFunctionConfig.post('manageAddress/add/${authID}', params);
    } catch (e) {
      LOG.e(e);
      throw Exception(e);
    }
  }

  //Edit/ Update Address Details
  Future<void> updateAddressDetails(
    String key,
    String address,
    String pincode,
    String phone,
    String name,
  ) async {
    try {
      var params = {
        "address": address,
        "pincode": pincode,
        "phone": phone,
        "name": name,
      };
      final request =
          await CloudFunctionConfig.put('manageAddress/update/${key}', params);

      if (request.statusCode == 200) {
        _addresses.map((e) {
          if (e.key == key) {
            e.address = address;
            e.pincode = pincode;
            e.phone = phone;
            e.name = name;
          }
        }).toList();
        LOG.i('Http Address Update request successful');
      } else {
        LOG.e(request.statusCode);
        LOG.e(request.body);
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  //Set as default Address Details
  Future<void> defaultAddressDetails(
    String key,
    String authID,
  ) async {
    try {
      final request = await CloudFunctionConfig.put(
          'manageAddress/default/${authID}/${key}', {});

      if (request.statusCode == 200) {
        _addresses.map((e) {
          if (e.key == key) {
            e.isPrimary = true;
          } else {
            e.isPrimary = false;
          }
        }).toList();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  //Delete Address Details
  Future<void> deleteAddressDetails(
    String key,
    String authID,
  ) async {
    try {
      final request =
          await CloudFunctionConfig.delete('manageAddress/delete/${key}');

      if (request.statusCode == 200) {
        _addresses.removeWhere((element) => element.key.compareTo(key) == 0);
        LOG.i('Http Delete Request Sent');
      } else {}
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
