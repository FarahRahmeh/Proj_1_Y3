import 'package:get/get.dart';

import '../../models/all_categories_model.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class AllCategoriesRepository extends GetxController {
  static Future<List<AllCategories>?> fechAllCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/allShelves'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );
    if (response.statusCode == 200) {
      print("success");

      var categories = response.body;
      return allCategoriesFromJson(categories);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<http.Response> getCategoryBooks(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/shelfBooks/$id'),
    );
    return response;
  }
}
