import 'dart:convert';


import 'package:http/http.dart' as http;
import '../model/user_api_response_model.dart';

class ApiServices {
  static const String baseUrl = "https://reqres.in/api/";
  static const String endPint = "users?";
  static const String params = "page=2";

  static Future<UserApiResponseModel?> getPages() async {
    try {
      var res = await http.get(Uri.parse("$baseUrl$endPint$params"));
      if (res.statusCode == 200) {
        var data = UserApiResponseModel.fromJson(jsonDecode(res.body));
        print(data);
        return data;
      } else {
        return UserApiResponseModel();
      }
    } catch (e) {
      print(e);
    }
  }
}
