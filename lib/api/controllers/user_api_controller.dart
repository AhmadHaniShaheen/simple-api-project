import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:api_secand_project/api/api_setting.dart';
import 'package:api_secand_project/models/user.dart';
import 'dart:developer' as devtool show log;

class UserApiController {
  Future<List<User>> getUser() async {
    var uri = Uri.parse(ApiSetting.users);
    var response = await http.get(uri);
    devtool.log('sdjf');
    devtool.log(response.statusCode.toString());
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      devtool.log(response.statusCode.toString());
      devtool.log(jsonResponse['data']);
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
