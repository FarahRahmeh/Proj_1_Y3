import 'dart:convert';

import 'package:booktaste/auth/login/login_controller.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_model.dart';
import 'package:booktaste/user/user_profile/user_profile_widgets/profile_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../../../utils/constans/api_constans.dart';

class DeleteaccountRepository extends GetxController {
   Future<ProfileMenu?> deleteAccount() async {
    final response = await http.delete(
      Uri.parse('$baseUrl/deleteAccount'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}'
      },
    );
    if (response.statusCode == 200) {
      print("success");
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

}
