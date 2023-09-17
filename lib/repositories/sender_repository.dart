import 'package:consulting_app_pailmail/models/senders/sender_response_model.dart';
import 'package:consulting_app_pailmail/models/senders/senders.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';
import '../models/senders/sender.dart';

class SenderRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<SenderResponseModel> createSender(Sender sender) async {
    Map<String, dynamic> map = {
      "name": sender.name,
      "mobile": sender.mobile,
      "address": sender.address,
      // take dynamic but the post method take the string
      "category_id": sender.categoryId,
    };
    final response = await _helper.post(sendersUrl, map);
    print("////////////////");
    return SenderResponseModel.fromJson(response);
  }

  Future<dynamic> updateSender(Sender sender, String id) async {
    Map<String, dynamic> map = {
      "name": sender.name,
      "mobile": sender.mobile,
      "address": sender.address,
      "category_id": sender.categoryId,
    };
    final response = await _helper.put(CRUD_senderUrl + id, map);
    return SenderResponseModel.fromJson(response);
  }

  Future<void> deleteSender(String id) async {
    await _helper.delete(CRUD_senderUrl + id);
    return;
  }

  Future<SendersClass?> getallSender() async {
    print("1....");
    final response = await _helper.getParams(CRUD_senderUrl, "mail", true);
    return Senders.fromJson(response).senders;
  }

  Future<SenderResponseModel> getSingleSender(String id) async {
    print("1....");

    final response = await _helper.getParam(sendersUrl, id, "mail",
        false); //E/flutter ( 8612): [ERROR:flutter/runtime/dart_vm_initializer.cc(41)] Unhandled Exception: Unauthorised: {"message":"Unauthenticated."}
    print("2....");

    print(response);
    return SenderResponseModel.fromJson(response);
  }
}
