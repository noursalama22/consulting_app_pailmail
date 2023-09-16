import 'dart:convert';

import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/models/users/user.dart';
import 'package:consulting_app_pailmail/models/users/user_response_model.dart';
import 'package:consulting_app_pailmail/storage/shared_prefs.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';

class AuthRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();
  final SharedPrefrencesController prefs = SharedPrefrencesController();
  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
    };

    final loginResponse = await _helper.post(loginUrl, body);
    // await SharedPrefrencesController().initPref();
    UserResponseModel userResponseModel =
        UserResponseModel.fromJson(loginResponse);
    print('${userResponseModel.user.name}');
    print('${userResponseModel.token}');
    SharedPrefrencesController().initPref();
    await SharedPrefrencesController().saveAuth(
        userModel: UserResponseModel(
            user: userResponseModel.user, token: userResponseModel.token),
        isLogin: false);
    print(SharedPrefrencesController().email);
    print(SharedPrefrencesController().token);
    print(SharedPrefrencesController().roleId);
    return UserResponseModel.fromJson(loginResponse);
  }

  Future<dynamic> register({
    required String email,
    required String password,
    required String password_confirmation,
    required String name,
  }) async {
    Map<String, String> body = {
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'name': name
    };

    final registerResponse = await _helper.post(registerUrl, body);

    await SharedPrefrencesController().saveAuth(
        userModel: UserResponseModel(user: User(), token: prefs.token),
        isLogin: true);
    print(SharedPrefrencesController().name);
    return UserResponseModel.fromJson(registerResponse);
  }
}
