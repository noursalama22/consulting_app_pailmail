import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../../storage/shared_prefs.dart';
import 'app_exception.dart';

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = _returnResponse(response);
      print("******************$responseJson");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

//{{palmail}}/senders?mail=true   for all sender
  Future<dynamic> getParams(String sender_url, String name, var params) async {
    var responseJson;
    String url = '$sender_url?$name=$params';
    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

//{{palmail}}/senders/50?mail=false for single sender
  Future<dynamic> getParam(
      String sender_url, String? id, String name, var params) async {
    var responseJson;

    String url = '$sender_url/$id?$name=$params';
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String url, Map<String, dynamic> body) async {
    var responseJson;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: body,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }


  Future<dynamic> postParams(
      String sender_url, bool params, Map<String, dynamic> body) async {
    var responseJson;

    String url = '$sender_url/senders/?mail=$params';
    print("2");
    try {
      print("3");
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      print("4");
      responseJson = _returnResponse(response);
      print(
          "5"); //E/flutter ( 8612): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Error During Communication: Error occurred while Communication with Server with StatusCode : 301

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

  Future<dynamic> delete(
    String url,
  ) async {
    var responseJson;

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return true;
  }

  Future<dynamic> put(String url, Map<String, String> body) async {
    var responseJson;
    try {
      final response =
          await http.put(Uri.parse(url), body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> delete(String url) async {
    var responseJson;
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: headers,
      );
      responseJson = _returnResponse(response);
      Future.value("delete successfully");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
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
