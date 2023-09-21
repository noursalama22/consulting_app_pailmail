import 'package:consulting_app_pailmail/models/mails/mail_response_model.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';

class SearchRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<MailResponseModel> search(
      {required String text,
      DateTime? start,
      DateTime? end,
      int? status_id}) async {
    String url = "$sendersUrl?mail=true";

    final response = await _helper.get(searchUrl + "text=${text}");
    print("*************$response");
    return MailResponseModel.fromJson(response);
    // final response = await _helper
    //     .get(searchUrl + "text=${text}&${start}&${end}&${status_id}");
  }
}
