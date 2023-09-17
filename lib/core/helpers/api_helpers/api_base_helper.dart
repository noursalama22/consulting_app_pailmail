import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../storage/shared_prefs.dart';
import 'app_exception.dart';

class ApiBaseHelper {
  var responseJson;

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, String> body) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      print("ttttttttttttttttttttttt" + response.statusCode.toString());
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postDel(
    String url,
  ) async {
    var responseJson;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> put(String url, Map<String, String> body) async {
    try {
      final response =
          await http.put(Uri.parse(url), body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<bool> delete(String url) async {
    try {
      final response = await http.delete(Uri.parse(url), headers: headers);
      if (_returnResponse(response)) {
        responseJson = true;
      } else {
        return false;
      }
    } on SocketException {
      return false;
    }
    return false;
  }

  Map<String, String> get headers {
    Map<String, String> header = <String, String>{};
    header[HttpHeaders.acceptHeader] = 'application/json';
    if (SharedPrefrencesController().loggedIn) {
      header[HttpHeaders.authorizationHeader] =
          SharedPrefrencesController().token;
    }
    return header;
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        print("rrrrrrrrrrrrrrrrrrrrrr" + response.body);
        var responseJson = json.decode(response.body);

        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body);
      case 401:
      case 403:
        throw UnauthorisedException(response.body);
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
