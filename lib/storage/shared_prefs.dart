import 'package:consulting_app_pailmail/models/users/user_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrefKeys { loggedIn, email, id, image, name, token, roleId }

class SharedPrefrencesController {
  static final SharedPrefrencesController _instance =
      SharedPrefrencesController._();
  late SharedPreferences _sharedPreferences;

  SharedPrefrencesController._();

  factory SharedPrefrencesController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<bool> saveAuth(
      {required UserResponseModel userModel, required bool isLogin}) async {
    try {
      await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
      await _sharedPreferences.setInt(
          PrefKeys.id.toString(), userModel.user.id!.toInt());
      await _sharedPreferences.setInt(
          PrefKeys.roleId.toString(), userModel.user.roleId.toInt());
      await _sharedPreferences.setString(
          PrefKeys.email.toString(), userModel.user.email.toString());
      await _sharedPreferences.setString(
          PrefKeys.name.toString(), userModel.user.name.toString());
      await _sharedPreferences.setString(
          PrefKeys.token.toString(), 'Bearer ${userModel.token}');
      if (isLogin) {
        await _sharedPreferences.setString(
            PrefKeys.image.toString(), userModel.user.image.toString());
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool?> setData(String key, dynamic data) async {
    switch (data.runtimeType) {
      case int:
        return _sharedPreferences.setInt(key, data);
      case String:
        return _sharedPreferences.setString(key, data);
      case bool:
        return _sharedPreferences.setBool(key, data);
    }
    return null;
  }

  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;
  String get email =>
      _sharedPreferences.getString(PrefKeys.email.toString()) ?? '';
  String get name =>
      _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';
  String get roleId =>
      _sharedPreferences.getString(PrefKeys.roleId.toString()) ?? '';
  String get id => _sharedPreferences.getString(PrefKeys.id.toString()) ?? '';
  String get image =>
      _sharedPreferences.getString(PrefKeys.image.toString()) ?? '';
  String get token =>
      _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';

  //
  // Future<dynamic> getData(String key) async {
  //   if (_sharedPreferences.containsKey(key)) {
  //     return _sharedPreferences.get(key);
  //   }
  // }

// Future<T?> getValueFor<T>(String key) async {
//   await _checkInstance();
//   if (_sharedPreferences!.containsKey(key)) {
//     return _prefs?.get(key) as T;
//   }
//   return null;
// }
  // bool get loggedIn =>
  //     _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;
  //
  // String get email =>
  //     _sharedPreferences.getString(PrefKeys.email.toString()) ?? ' ';

  Future<bool> remove({required String key}) async {
    if (_sharedPreferences.containsKey(key)) {
      return await _sharedPreferences.remove(key);
    }
    return false;
  }

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
