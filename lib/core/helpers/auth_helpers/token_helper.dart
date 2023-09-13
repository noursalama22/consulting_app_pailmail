import 'package:consulting_app_pailmail/storage/shared_prefs.dart';

Future<String> getToken() async {
  return await SharedPrefsController().getData('token');
}
