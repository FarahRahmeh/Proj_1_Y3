import 'dart:convert';

import 'package:booktaste/models/cafe_model.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../models/cafe_shelf_model.dart';
import '../../user/user_home/all_categories_model.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class BookRepository extends GetxController {
  Future<void> getBookCover(String imageUrl) async {
    await http.get(
      Uri.parse('$baseUrl/$imageUrl'), // covers/$url
    );
    //return response;
  }

  Future<http.Response> getBookDetails(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/bookDetails/$id'), // covers/$url
    );
    return response;
  }
}
