import 'package:consulting_app_pailmail/models/roles/role_response_model.dart';
import 'package:flutter/material.dart';

import '../core/helpers/api_helpers/api_response.dart';
import '../repositories/roles_repository.dart';

class RoleProvider extends ChangeNotifier {
  late RoleRepository _roleRepository;

  late ApiResponse<List<Roles>> _roleList;

  ApiResponse<List<Roles>> get roleList => _roleList;

  RoleProvider() {
    _roleRepository = RoleRepository();
    fetchRoleList();
  }

  fetchRoleList() async {
    _roleList = ApiResponse.loading('Fetching Links');
    notifyListeners();
    try {
      List<Roles>? roles = await _roleRepository.fetchRoleList();
      _roleList = ApiResponse.completed(roles);
      notifyListeners();
    } catch (e) {
      _roleList = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }
}
