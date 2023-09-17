import 'dart:convert';

import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_base_helper.dart';

import '../core/utils/constants.dart';
import '../models/mails/mail.dart';
import '../models/mails/mail_response_model.dart';

class MailsRepository {
  final ApiBaseHelper _hepler = ApiBaseHelper();
  Future<List<Mail>?> fetchAllMails() async {
    final response = await _hepler.get(allMailsUrl);

    return MailResponseModel.fromJson(response).mails;
  }

  Future<List<Mail>?> fetchSingleMail({required String id}) async {
    final response = await _hepler.get(CRUD_mailsUrl + id);
    return MailResponseModel.fromJson(response).mails;
  }

  Future<List<Mail>?> createMail(
      {required String subject,
      String? description,
      required String sender_id,
      required String archive_number,
      required String archive_date,
      String? decision = '',
      required String status_id,
      String? final_decision,
      List<int>? tags,
      List<Map<String, dynamic>>? activities}) async {
    final Map<String, dynamic> body = {
      "subject": subject,
      "description": description,
      "sender_id": 50,
      "archive_number": "20000",
      "archive_date": archive_date,
      "decision": decision,
      "status_id": status_id,
      "final_decision": final_decision,
      "tags": jsonEncode(tags),
      "activities": jsonEncode(activities)
    };
    final response = await _hepler.post(allMailsUrl, body);
    print("create mail");
    return MailResponseModel.fromJson(response).mails;
  }

  Future<Mail> updateMail(
      {required String id,
      String? decision,
      required int status_id,
      String? final_decision,
      List<int>? tags,
      List<int>? idAttachmentsForDelete,
      List<int>? pathAttachmentsForDelete,
      List<Map<String, dynamic>>? activities}) async {
    final Map<String, dynamic> body = {
      "decision": decision,
      "status_id": status_id,
      "final_decision": final_decision,
      "tags": jsonEncode(tags),
      "activities": activities,
      "idAttachmentsForDelete": jsonEncode(idAttachmentsForDelete),
      "pathAttachmentsForDelete": jsonEncode(pathAttachmentsForDelete)
    };
    final response = await _hepler.put(allMailsUrl + id, body);
    return Mail.fromJson(response);
  }

  Future<bool> deleteMail({required String id}) async {
    final response = await _hepler.delete(allMailsUrl + id);
    return response;
  }
}
