import 'package:booktaste/models/cafe_model.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/cafe_shelf_model.dart';
import '../../models/all_categories_model.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class CafesRepository extends GetxController {
  static Future<List<Cafe>?> fechAllCafes() async {
    final response = await http.get(Uri.parse('$baseUrl/allCafe'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success");
      var cafes = response.body;
      return cafesFromJson(cafes);
    } else {
      print('cafe repo error' + response.statusCode.toString());
      return null;
    }
  }

  Future<List<CafeShelf>?> fetchCafeShelves(var cafeId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/cafeShelves/$cafeId'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );

    if (response.statusCode == 200) {
      if (response.body.isNotEmpty) {
        var cafeShleves = response.body;
        cafeshlevesFromJson(cafeShleves);
        return cafeshlevesFromJson(cafeShleves);
      }
    } else {
      print(response.statusCode);
      Loaders.errorSnackBar(title: response.body.toString());
      return null;
    }
    return null;
  }

  static Future<http.Response> getCafeBooks(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/cafeBooks/$id'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    });
    return response;
  }
}
