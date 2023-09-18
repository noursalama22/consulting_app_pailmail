import 'package:consulting_app_pailmail/models/tags/tag_response_model.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';
import '../models/tags/tag.dart';

class TagRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<dynamic> createTag(String tag) async {
    Map<String, String> map = {
      "name": tag,
    };
    final response = await _helper.post(allTagsUrl, map);
    print("1....");
    return TagResponseModel.fromJson(response);
  }

  Future<List<Tag>?> getTags() async {
    print("1....");
    final response = await _helper.get(allTagsUrl);
    print("2....");
    print("${TagResponseModel.fromJson(response).tags}");
    return TagResponseModel.fromJson(response).tags;
  }

  //{{baseUrl}}/mails/{id}/tags
  Future<List<Tag>?> getTagsOfMail(String id) async {
    print("1....");
    final response = await _helper.get("$CRUD_mailsUrl+$id/tags");
    print("2....");
    return TagResponseModel.fromJson(response).tags;
  }

  Future<List<Tag>?> getMailWithTags(List<String> list) async {
    print("1....");

    final response = await _helper.getParams(allTagsUrl, "tags", list);
    print("2....");

    return TagResponseModel.fromJson(response).tags;
  }
}
