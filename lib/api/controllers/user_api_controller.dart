import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_secand_project/api/api_setting.dart';
import 'package:api_secand_project/models/user.dart';

class UserApiController {
  Future<List<User>> getUser() async {
    var uri = Uri.parse(ApiSetting.users);
    var response = await http.get(uri);
    print('sdjf');
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print(response.statusCode);
      print(jsonResponse['data']);
      var userJsonArray = jsonResponse['data'] as List;
      return userJsonArray
          .map((jsonObject) => User.fromJson(jsonObject))
          .toList();
    }
    return [];
  }
}
/*
* Hi Ahmad
* you are the best
* you can solve this problem
* let me show you
 */
