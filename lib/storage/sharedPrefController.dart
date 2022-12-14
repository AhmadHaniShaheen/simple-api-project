import 'package:api_secand_project/models/strudent.dart';
import 'package:shared_preferences/shared_preferences.dart';


enum prefKeys {
  loggedIn,
  id,
  full_name,
  email,
  gender,
  token,
}

class SharedPrefController {

  late SharedPreferences _sharedPreferences;
  static final SharedPrefController _instace = SharedPrefController._();

  factory SharedPrefController(){
    return _instace;
  }

  SharedPrefController._();

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> save({required Student student}) async {
    await _sharedPreferences.setBool(prefKeys.loggedIn.name, true);
    await _sharedPreferences.setInt(prefKeys.id.name, student.id);
    await _sharedPreferences.setString(prefKeys.email.name, student.email);
    await _sharedPreferences.setString(prefKeys.gender.name, student.gender);
    await _sharedPreferences.setString(prefKeys.token.name,'Bearer ${student.token}');
  }

  T? getValue<T>({required String key}){
    return _sharedPreferences.get(key) as T?;
  }
  Future<bool> clear()async {
    return await _sharedPreferences.clear();
  }
}