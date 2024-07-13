import 'package:get/get.dart';

import '../../user/user_home/all_categories_model.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class AllCategoriesRepository extends GetxController {
  static Future<List<AllCategories>?> fechAllCategories() async {
    final response = await http.get(
      Uri.parse('$baseUrl/allShelves'),
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
}
