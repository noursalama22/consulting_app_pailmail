import 'package:consulting_app_pailmail/models/users/user_response_model.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';

class AuthRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> login(Map<String, String> body) async {
    final loginResponse = await _helper.post("/login", body, {});
    return UserResponseModel.fromJson(loginResponse);
  }

  Future<dynamic> register(Map<String, String> body) async {
    final registerResponse = await _helper.post("/register", body, {});
    return UserResponseModel.fromJson(registerResponse);
  }
}
