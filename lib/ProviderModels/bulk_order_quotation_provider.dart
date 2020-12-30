import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/config/function_config.dart';

class BulkOrderQuotationProvider with ChangeNotifier{


  void initQuotation(String key) async {

    await getQuotation(key);

    notifyListeners();

  }

  Future<void> getQuotation(String key) async{

    final response =
        await http.get(FunctionConfig.host + 'manageOrders/custom-order/$key', headers: {"Content-Type": "application/json"},);

    if(response.statusCode == 200){

      print("Quatation  :  "  + response.body);


    }

  }


}