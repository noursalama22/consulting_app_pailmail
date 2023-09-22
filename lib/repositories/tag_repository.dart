import 'package:consulting_app_pailmail/models/tags/tag_response_model.dart';
import 'package:consulting_app_pailmail/models/tags/tags_with_mails.dart';

import '../core/helpers/api_helpers/api_base_helper.dart';
import '../core/utils/constants.dart';
import '../models/tags/tag.dart';
import '../models/tags/tags_of_mail.dart';

class TagRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<TagResponseModel> createTag(String tag) async {
    Map<String, String> map = {
      "name": tag,
    };
    final response = await _helper.post(allTagsUrl, map);
    return TagResponseModel.fromJson(response);
  }

  Future<List<Tag>?> getTags() async {
    print("ssssssss");
    final response = await _helper.get(allTagsUrl);
    print("getTags");
    print("${TagResponseModel.fromJson(response).tags![0].name}");
    return TagResponseModel.fromJson(response).tags;
  }

  //{{baseUrl}}/mails/{id}/tags
  Future<List<Tag>?> getTagsOfMail(String id) async {
    final response = await _helper.get("$CRUD_mailsUrl$id/tags");
    return TagsOfMail.fromJson(response).tags;
  }

  Future<List<Tag>?> getMailWithTags(List<dynamic> list) async {
    print("1....1");
    final response = await _helper.get("$allTagsUrl?tags=$list");
    print("2....2");
    return TagsWithMails.fromJson(response).tags;
  }
}
