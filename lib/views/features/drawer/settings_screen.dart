import 'package:consulting_app_pailmail/models/roles/role_response_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/helpers/api_helpers/api_response.dart';
import '../../../providers/roles_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RoleProvider>(
        builder: (_, roleProvider, __) {
          if (roleProvider.roleList.status == ApiStatus.LOADING) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (roleProvider.roleList.status == ApiStatus.ERROR) {
            return Center(
              child: Text('${roleProvider.roleList.message}'),
            );
          }
          print(roleProvider.roleList.data?[3].role);
          print(roleProvider.roleList.data?[3].usersCount);
          print(roleProvider
              .roleList.data?[2].users?[0].name); //////////**********///////
          return Center(
            child: ListView.builder(
              itemCount: roleProvider.roleList.data?.length,
              itemBuilder: (context, index) {
                Roles roles = roleProvider.roleList.data![index];

                return Text('${roles.role?.name}');
              },
            ),
          );
        },
      ),
    );
  }
}
