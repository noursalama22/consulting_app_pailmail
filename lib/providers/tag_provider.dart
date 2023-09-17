import 'package:consulting_app_pailmail/models/tags/tag.dart';
import 'package:flutter/cupertino.dart';

import '../core/helpers/api_helpers/api_response.dart';
import '../repositories/tag_repository.dart';

class TagProvider extends ChangeNotifier {
  late TagRepository _repository;
  late ApiResponse<List<Tag>> _tagList;

  ApiResponse<List<Tag>> get tagList => _tagList;

  SenderProvider() {
    _repository = TagRepository();
    getTagList();
  }

  getTagList() async {
    _tagList = ApiResponse.loading("Fetching Tags");
    notifyListeners();
    try {
      List<Tag>? senders = await _repository.getTags();
      _tagList = ApiResponse.completed(senders);
      notifyListeners();
    } catch (error) {
      _tagList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
