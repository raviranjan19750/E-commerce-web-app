import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/configs.dart';

import '../logger.dart';

class FooterRepository {
  var LOG = LogBuilder.getLogger();

  Future<dynamic> getAboutUs(String endPoint) async {

    LOG.i("fetching Html Response of $endPoint");
    var response = await CloudFunctionConfig.get("manageDocuments/$endPoint");

    if (response.statusCode == 200) {
      return response.body;
    } else {
      LOG.i(Strings.htmlResponseError + " statusCode: " + response.statusCode.toString());
    }

    return "";
  }
}
