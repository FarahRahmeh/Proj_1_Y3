import 'package:booktaste/models/book.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'user_rating_model.dart';

class RateRepository extends GetxController {
  var rateList = <Rate>[].obs;

  static Future<Rate?> submitRating(int bookId, double rating) async {
    final response = await http.get(
      Uri.parse('$baseUrl/rate/$bookId/$rating'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}'
      },
    );
    if (response.statusCode == 200) {
      Get.snackbar('Success', 'Rating submitted successfully',
          snackPosition: SnackPosition.BOTTOM);
      var rate = response.body;
      return rateFromJson(rate);
    } else {
      Get.snackbar('Error', 'Failed to submit rating',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }
}
