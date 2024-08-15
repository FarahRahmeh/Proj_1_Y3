import 'dart:convert';

import 'package:booktaste/auth/login/login_controller.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/constans/api_constans.dart';

class FeedbackRepository extends GetxController {
  static Future<FeedbackP?> putFeedback(String feedback, int id) async {
    final body = jsonEncode({'feedback': feedback});
    final response = await http.post(
      Uri.parse('$baseUrl/feedback/$id'),
      body: body,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}'
      },
    );
    if (response.statusCode == 200) {
      print("success");
      var feedback = response.body;
      return feedbackFromJson(feedback);
    } else {
      print(response.statusCode);
      print(response.body);
      return null;
    }
  }

  static Future<List<FeedbackG>?> getFeedbacks(int bookId) async {
    // final token = GetStorage().read('TOKEN');
    final response = await http.get(
      Uri.parse('$baseUrl/bookFeedback/$bookId'),
      headers: {
        'Accept': 'application/json',
        // 'Content-Type': 'application/json',
        // 'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      },
    );
    if (response.statusCode == 200) {
      var feedback = response.body;
      print(feedback);
      return feedbackgFromJson(feedback);
    } else {
      return null;
    }
  }
}
