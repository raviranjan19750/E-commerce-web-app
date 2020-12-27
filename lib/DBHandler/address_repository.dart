import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

class AddresssRepository {
  // Get Address Details

  Future<List<Address>> getAddressDetails(String authID) async {
    try {
      final response =
          await http.get(FunctionConfig.host + 'manageAddress/list/${authID}');
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((i) => Address.fromJson(i))
            .toList();
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
      final request = await http.post(
          FunctionConfig.host + 'manageAddress/add/${authID}',
          body: params);
      if (request.statusCode == 200) {
        print('Http Get request sucessfull');
      } else {}
    } catch (e) {
      print(e.toString());
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
      final request = await http.put(
          FunctionConfig.host + 'manageAddress/update/${key}',
          body: params);
      if (request.statusCode == 200) {
        print('Http Get request sucessfull');
      } else {}
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
      final request = await http.put(
        FunctionConfig.host + 'manageAddress/default/${authID}/${key}',
      );
      if (request.statusCode == 200) {
        print('Http Get request sucessfull');
      } else {}
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
      final request = await http.delete(
        FunctionConfig.host + 'manageAddress/delete/${key}',
      );
      if (request.statusCode == 200) {
        print('Http Get request sucessfull');
      } else {}
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
