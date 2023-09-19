import 'package:consulting_app_pailmail/models/tags/tag.dart';
import 'package:flutter/cupertino.dart';

import '../core/helpers/api_helpers/api_response.dart';
import '../repositories/tag_repository.dart';

class TagProvider extends ChangeNotifier {
  String id = "101";
  List<String> list = ["38", "45", "27"];

  late TagRepository _repository;
  late ApiResponse<List<Tag>> _tagList;

  ApiResponse<List<Tag>> get tagList => _tagList;

  ApiResponse<List<Tag>> get tagWithMailList => _tagList;

  ApiResponse<List<Tag>> get tagOMailList => _tagList;

  TagProvider() {
    _repository = TagRepository();
    getTagList();
    getTagOfMailList(id);
    //getTagWithMailList(list);
  }

  getTagList() async {
    _tagList = ApiResponse.loading("Fetching Tags");
    notifyListeners();
    try {
      List<Tag>? tags = await _repository.getTags();
      print(tags);
      _tagList = ApiResponse.completed(tags);
      notifyListeners();
    } catch (error) {
      _tagList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  getTagOfMailList(String id) async {
    _tagList = ApiResponse.loading("Fetching Tags");
    notifyListeners();
    try {
      List<Tag>? tags = await _repository.getTagsOfMail(id);
      // print(tags);
      _tagList = ApiResponse.completed(tags);
      notifyListeners();
    } catch (error) {
      _tagList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }

  getTagWithMailList(List<dynamic> list) async {
    _tagList = ApiResponse.loading("Fetching Tags");
    notifyListeners();
    try {
      List<Tag>? tags = await _repository.getMailWithTags(list);
      // print(tags);
      _tagList = ApiResponse.completed(tags);
      notifyListeners();
    } catch (error) {
      _tagList = ApiResponse.error(error.toString());
      notifyListeners();
    }
  }
}
