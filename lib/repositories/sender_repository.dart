import 'package:consulting_app_pailmail/models/senders/sender_response_model.dart';
import 'package:consulting_app_pailmail/models/senders/sender_response_model_1.dart';
import 'package:consulting_app_pailmail/models/senders/senders.dart';
import 'package:consulting_app_pailmail/models/senders/senders_1.dart';
import 'package:consulting_app_pailmail/models/statuses/status_reponse_model.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';
import '../models/senders/sender.dart';

class SenderRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<SenderResponseModel_1> createSender(Sender sender) async {
    Map<String, dynamic> map = {
      "name": sender.name,
      "mobile": sender.mobile,
      "address": sender.address,
      // take dynamic but the post method take the string
      "category_id": sender.categoryId.toString(),
    };
    final response = await _helper.post(sendersUrl, map);
    print("////////////////");
    return SenderResponseModel_1.fromJson(response);
  }

  Future<SenderResponseModel_1> updateSender(Sender sender, String id) async {
    Map<String, dynamic> map = {
      "name": sender.name,
      "mobile": sender.mobile,

      "address": sender.address,
      "category_id": sender.categoryId.toString(),
    };
    final response = await _helper.put(CRUD_senderUrl + id, map);
    return SenderResponseModel_1.fromJson(response);
  }

  Future<void> deleteSender(String id) async {
    await _helper.delete(CRUD_senderUrl + id);
  }

  Future<List<Data>?> getallSender() async {
    String url = "$sendersUrl?mail=true";

    final response = await _helper.get(url);
    return SenderResponseModel_1.fromJson(response).senders!.data;
  }

  //{{palmail}}/senders/127?mail=false

  Future<Sender?> getSingleSender(String id) async {
    print("1.... $id"); //{{palmail}}/senders/{id}?mail=false
    String url = "$CRUD_senderUrl$id?mail=false";
    final response = await _helper.get(url);
    // final response = await _helper.getParam(CRUD_senderUrl, id, "mail", false);
    print(".............${response}................."); //طبع
    print(
        "TEST,,,,,,,,,,,,,,,,,,,,, ${SenderResponseModel.fromJson(response).sender!.name}");
    return Sender.fromJson(response);
  }
}
