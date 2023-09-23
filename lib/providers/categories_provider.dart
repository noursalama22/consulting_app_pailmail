import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_response.dart';
import 'package:consulting_app_pailmail/models/categories/category_response_model.dart';
import 'package:consulting_app_pailmail/models/mails/mail.dart';
import 'package:consulting_app_pailmail/repositories/categories_repositry.dart';
import 'package:flutter/material.dart';

class CategoriesProvider extends ChangeNotifier {
  late ApiResponse<List<CategoryElement>> _allCategories;
  int _index = 0;
  int _senderIndex = -1; //there is nothing element selected..
  int _categoryIndex = 0;

  // late ApiResponse<List<Mail>> _mailsCategories1;
  // late ApiResponse<List<Mail>> _mailsCategories2;
  // late ApiResponse<List<Mail>> _mailsCategories3;
  // late ApiResponse<List<Mail>> _mailsCategories4;
  List<ApiResponse<List<Mail>>> _mailsCategories = [];
  late CategoryRepository _categoryRepository;

  CategoriesProvider() {
    _categoryRepository = CategoryRepository();
    fetchAllCategories();
    // fetchCategory1Mails(categoryId: "2");
    // fetchCategory2Mails(categoryId: "3");
    // fetchCategory3Mails(categoryId: "4");
    // fetchCategory4Mails(categoryId: "1");
    //
    // fetchCategoryMails(categoryId: "2", index: 0);
    // fetchCategoryMails(categoryId: "3", index: 1);
    // fetchCategoryMails(categoryId: "4", index: 2);
    // fetchCategoryMails(categoryId: "1", index: 3);
  }

  ApiResponse<List<CategoryElement>> get allCategories => _allCategories;

  List<ApiResponse<List<Mail>>> get mailsCategory => _mailsCategories;

  int get selectedIndex => _index;
  int get categoryPosition => _categoryIndex;

  int get senderPosition => _senderIndex;

  void fetchAllCategories() async {
    _allCategories = ApiResponse.loading("Loading");
    notifyListeners();
    try {
      final response = await _categoryRepository.fetchCategories();
      _allCategories = ApiResponse.completed(response);
      notifyListeners();
    } catch (e) {
      _allCategories = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

  void fetchCategoryMails(
      {required String categoryId, required int index}) async {
    _mailsCategories.add(ApiResponse.loading("Loading"));
    notifyListeners();
    try {
      final response =
          await _categoryRepository.fetchCategoryMails(categoryId: categoryId);
      _mailsCategories[index] = ApiResponse.completed(response);
      //print("rrrrrrrrrrrrrr" + _mailsCategories1[index].data![0].id.toString());
      notifyListeners();
    } catch (e) {
      _mailsCategories[index] = ApiResponse.error(e.toString());
      notifyListeners();
    }
  }

//to change category
  changeSelectedCategory({required int selectedIndex}) {
    _index = selectedIndex;
    notifyListeners();
  }

//to change sender
  getSender({required int selectedIndex, int? categoryIndex = 0}) {
    _senderIndex = selectedIndex;
    _categoryIndex = categoryIndex!;
    notifyListeners();
  }
}
