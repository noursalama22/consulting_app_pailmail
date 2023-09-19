import 'package:consulting_app_pailmail/core/helpers/api_helpers/api_base_helper.dart';
import 'package:consulting_app_pailmail/core/utils/constants.dart';
import 'package:consulting_app_pailmail/models/categories/category_response_model.dart';
import 'package:consulting_app_pailmail/models/categories/mails_of_category.dart';
import 'package:consulting_app_pailmail/models/mails/mail.dart';

class CategoryRepository {
  final ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<CategoryElement>?> fetchCategories() async {
    final allCategoriesResponse = await _helper.get(allCategoriesUrl);

    return CategoryResponseModel.fromJson(allCategoriesResponse).categories;
  }

  //TODO:Use this response :)
  Future<CategoryElement> getSingleCategory(
      {required String categoryId}) async {
    final singleCategoryResponse =
        await _helper.get("$categoryMailUrl$categoryId");
    //   print(singleCategoryResponse['category']);
    return CategoryElement.fromJson(singleCategoryResponse['category']);
  }

  Future<void> createCategory({required String categoryName}) async {
    Map<String, String> body = {'name': categoryName};
    final createCategoryResponse = await _helper.post(allCategoriesUrl, body);
    //TODO: Complete the response handling
  }

  Future<List<Mail>?> fetchCategoryMails({required String categoryId}) async {
    // print("**************mails}");
    print("**************$categoryMailUrl${categoryId}/mails");

    final categoryMailsResponse =
        await _helper.get("$categoryMailUrl${categoryId}/mails");
    print("*************categoryMailsResponse${categoryMailsResponse}");
    return MailsOfCategory.fromJson(categoryMailsResponse).mails;
  }
}
