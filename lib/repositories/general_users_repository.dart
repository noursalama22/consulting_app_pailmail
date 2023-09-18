import 'package:consulting_app_pailmail/models/users/general_users_response_model.dart';
import 'package:consulting_app_pailmail/models/users/user.dart';
import 'package:consulting_app_pailmail/storage/shared_prefs.dart';
import 'package:provider/provider.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';
import '../providers/general_users_provider.dart';

class GeneralUsersRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<User>?> fetchGeneralUsersList() async {
    print('general users repo');
    final response = await _helper.get(allUsersUrl);
    return GeneralUserModelResponse.fromJson(response).users;
  }

  //todo: return create user api

  Future<User> changeUserRole({
    required String userId,
    required String updatedRoleId,
  }) async {
    print('changeUserRole  repo');
    Map<String, String> body = {'role_id': updatedRoleId};
    final response = await _helper.put('$CRUD_UsersUrl$userId/role', body);
    return User.fromJson(response['user']);
  }

  Future<User> changeUserPassword({
    required String userId,
    required String updatedPass,
    required String updatedConfoirmPass,
  }) async {
    print('changeUserPassword  repo');
    Map<String, String> body = {
      'password': updatedPass,
      'password_confirmation': updatedConfoirmPass
    };
    final response = await _helper.post('$CRUD_UsersUrl$userId/password', body);
    return User.fromJson(response['user']);
  }

  Future<User> changeGeneralUserName({
    required String userId,
    required String updatedName,
  }) async {
    print('changeGeneralUserName  repo');
    final response =
        await _helper.put('$CRUD_UsersUrl$userId?name=$updatedName', {});
    return User.fromJson(response['user']);
  }

  Future<User> getSingleGeneralUser({
    required String userId,
  }) async {
    print('getSingleGeneralUser  repo');
    final response = await _helper.get('$CRUD_UsersUrl$userId');
    return User.fromJson(response['user']);
  }

  Future<bool> deleteGeneralUser({
    required String userId,
  }) async {
    print('deleteGeneralUser  repo');
    var result = await _helper.delete(
      '$CRUD_UsersUrl$userId',
    );
    return result;
  }
}
