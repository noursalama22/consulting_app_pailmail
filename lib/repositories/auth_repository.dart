
import 'package:http/http.dart' as http;
import 'dart:io';


import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/models/users/user.dart';
import 'package:consulting_app_pailmail/models/users/user_response_model.dart';
import 'package:consulting_app_pailmail/storage/shared_prefs.dart';
import 'package:image_picker/image_picker.dart';

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
//  sender_repositories

//     final loginResponse = await _helper.post(loginUrl, body);
    // await SharedPrefrencesController().initPref();
//     UserResponseModel userResponseModel =
//         UserResponseModel.fromJson(loginResponse);
//     print('${userResponseModel.user.name}');
//     print('${userResponseModel.token}');
//     SharedPrefrencesController().initPref();
//     await SharedPrefrencesController().saveAuth(
//         userModel: UserResponseModel(
//             user: userResponseModel.user, token: userResponseModel.token),
//         isLogin: false);
//     print(SharedPrefrencesController().email);
//     print(SharedPrefrencesController().token);
//     // print(SharedPrefrencesController().roleId);
//     return UserResponseModel.fromJson(loginResponse);


    final loginResponse = await _helper.post(loginUrl, body);

//     var user = UserResponseModel.fromJson(loginResponse);
//     _prefs.saveAuth(userModel: user, isLogin: true);
//     // print("********************${_prefs.email}");
//     return UserResponseModel.fromJson(loginResponse);

    await SharedPrefrencesController().initPref();
    UserResponseModel userResponseModel =
        UserResponseModel.fromJson(loginResponse);

    print('${userResponseModel.user.name}');

    print('${userResponseModel.user.role?.name}');

    await SharedPrefrencesController().saveAuth(
        userModel: UserResponseModel(
          user: userResponseModel.user,
          token: userResponseModel.token,
        ),
        isLogin: false);

    return userResponseModel;

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
//  sender_repositories

//     await SharedPrefrencesController().saveAuth(
//         userModel: UserResponseModel(user: User(), token: prefs.token),
//         isLogin: true);
//     print(SharedPrefrencesController().name);

    UserResponseModel userResponseModel =
        UserResponseModel.fromJson(registerResponse);
    //save locally
    await SharedPrefrencesController().saveAuth(
        userModel: UserResponseModel(
            user: userResponseModel.user, token: userResponseModel.token),
        isLogin: true);
    print(SharedPrefrencesController().name);


    return UserResponseModel.fromJson(registerResponse);
  }

  Future<dynamic> fetchCurrentUser() async {
    final currentUserResponse = await _helper.get(currentUserInfoUrl);
    print('fetchCurrentUser');
    print(currentUserResponse);
    return UserResponseModel.fromJson(currentUserResponse);
  }

  Future<dynamic> updateCurrentUser({
    required String name,
    required String image,
  }) async {
    Map<String, String> body = {
      'name': name,
      'image': image,
    };
    print('upddatetUser');
    print(currentUpdateUserUrl);

    final upddatetUserResponse = await _helper.post(currentUpdateUserUrl, body);
    SharedPrefrencesController().setData(PrefKeys.name.toString(), name);
    SharedPrefrencesController().setData(PrefKeys.image.toString(), image);
    print(
        '${SharedPrefrencesController().setData(PrefKeys.name.toString(), name)}');
    print('updateCurrentUser authrepo');
    print(upddatetUserResponse);
    return UserResponseModel.fromJson(upddatetUserResponse);
  }

  Future<dynamic> LogoutUser() async {
    final logoutResponse = await _helper.postDel(logoutrUrl);
    // await SharedPrefrencesController().clear();
    return UserResponseModel.fromJson(logoutResponse);
  }

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return null;
    }
    File imageFile = File(pickedImage.path);
    return imageFile;
  }

  // Future<void> uploadProfileImage(File imageFile) async {
  //   var request =
  //       http.MultipartRequest("POST", Uri.parse('$baseUrl/user/update'));
  //   var newImage = await http.MultipartFile.fromPath('image', imageFile.path);
  //   request.fields['title'] = 'image_${DateTime.now()}';
  //   request.files.add(newImage);
  //   request.headers.addAll({
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${SharedPrefrencesController().token}'
  //   });
  //   var response = await request.send();
  //   var responseStream = await response.stream.toBytes();
  //   var responseString = String.fromCharCodes(responseStream);
  //
  //   print(responseString);
  //   print('uploadProfileImage auth repo');
  // }
  //
  // Future<String?> getNewProfilePic() async {
  //   print('getNewProfilePic auth repo');
  //
  //   final imageResponse = await _helper.get((currentUserInfoUrl));
  //   return UserResponseModel.fromJson(imageResponse).user.image;
  // }
}
