import 'package:http/http.dart' as http;
import 'oth_auth_constant.dart';
import 'dart:convert';


class DataServie {
   Future<String> getOthToken() async {
    var token = "";
    final basicAuth = 'Basic ' + base64Encode(utf8.encode('$oth_username:$oth_password'));; 
    final response = await http.get(oth_get_token_url,
     headers: <String,String>{
       'authorization': basicAuth
     });
    token = jsonDecode(response.body)["token"];
    return token;
  }

  Future<String> getOthMeasurementId() async {
    final response = await http.get(oth_get_measurement_id_url, headers: {'Authorization': 'Bearer ' + oth_token});
    return response.body;
  }
}