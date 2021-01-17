

import 'package:living_desire/config/CloudFunctionConfig.dart';

import '../logger.dart';

class FooterRepository {

  var LOG = LogBuilder.getLogger();
  
  Future<dynamic> getAboutUs(String endPoint) async {
    
    var response = await CloudFunctionConfig.get("manageDocuments/about-us");

    if(response.statusCode == 200) {
      LOG.i("response : " + response.body);
      return response.body;
    }

    return "";
    
  }



}