import 'dart:convert';

import 'package:booktaste/models/cafe_model.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';

import '../../models/cafe_shelf_model.dart';
import '../../user/user_home/all_categories_model.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class CafesRepository extends GetxController {
  static Future<List<Cafes>?> fechAllCafes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/allCafe'),
    );
    if (response.statusCode == 200) {
      print("success");
      var cafes = response.body;
      return cafesFromJson(cafes);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static Future<List<CafeShelf>?> fetchCafeShelves(var cafeId) async {
    // String id = cafeId ;
    final response = await http.get(
      Uri.parse('$baseUrl/cafeShelves/$cafeId'),
      // headers: {
      //   'Accept': 'application/json',
      //   'Content-Type': 'application/json'
      // },
    );

    if (response.statusCode == 200) {
      var cafeShleves = response.body;

      return cafeshlevesFromJson(cafeShleves);

      // List<dynamic> data = jsonDecode(response.body);
      // return data.map((json) => CafeShelf.fromJson(json)).toList();
    } else {
      print(response.statusCode);
      return Loaders.errorSnackBAr(title: response.body.toString());
      //throw Exception('Failed to load cafe shelves');
    }
  }
}
