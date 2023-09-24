import 'dart:convert';

import 'package:consulting_app_pailmail/models/mails/mail_response_model.dart';
import 'package:consulting_app_pailmail/models/senders/sender.dart';
import 'package:consulting_app_pailmail/repositories/sender_repository.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';
import '../models/senders/senders_1.dart';

class SearchRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<MailResponseModel> search(
      {required String text,
      DateTime? start,
      DateTime? end,
      String? status_id}) async {
    final response =
        await _helper.get(searchUrl + "text=${text}&status_id=${status_id}");
    print(searchUrl + "text=${text}&status_id=${status_id}");
    // print("*************$response");
    print('search done ');
    return MailResponseModel.fromJson(response);
    // final response = await _helper
    //     .get(searchUrl + "text=${text}&${start}&${end}&${status_id}");
  }

  Future<List<Data>?> searchSenders(String inputText) async {
    print("uuuuuuuuuuuuuuuuuuuuuuuuuuuu");

    // 1. استرجاع قائمة المرسلين
    List<Data>? senders = await SenderRepository().getallSender();
    // List<Data> userList =
    //     senders!.map((userData) => Data.fromJson(jsonEncode(userData))).toList();
    // 2. استخدام دالة where للبحث عن العناصر التي تطابق الشرط
    List<Data>? filteredUsers;
    for (int i = 0; i < senders!.length; i++) {
      filteredUsers = senders
          ?.where((senderInfo) =>
              senderInfo.name != null && senderInfo.name!.contains("hi"))
          .toList();
    }

    print(filteredUsers);

    if (filteredUsers!.isNotEmpty) {
      return filteredUsers;
    } else {
      throw Exception("Not Found Sender");
    }
  }
}
