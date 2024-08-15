import 'dart:convert';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class GenreReadPercentController extends GetxController {
  var shelfReadPerc = <String, int>{}.obs;
  var isGRPLoading = false.obs;

  final List<String> genres = [
    'Fantasy',
    'Romance',
    'Poetry',
    'Drama',
    'Literature',
    'Fairy Tales & Folklore',
    'Mystery',
    'Crime',
    'Thriller',
    'Horror',
    'Adventure',
    'Science',
    'Science fiction',
    'Technology',
    'Comics',
    'Manga',
    'Humor',
    'Travel',
    'Religion',
    'History',
    'Philosophy',
    'Psychology',
    'Life Stories',
    'Health',
    'Business',
    'Self-Help',
    'Education',
    'Children’s literature',
    'Picture book',
    'Young adult',
  ];

  final List<Color> colors = [
    Color(0xffFFD1DC), // pastel pink
    Color(0xffFFB347), // pastel orange
    Color(0xffFFD700), // pastel yellow
    Color(0xff9FE2BF), // pastel green
    Color(0xffB19CD9), // pastel purple
    Color(0xffFF6961), // pastel red
    Color(0xff77DD77), // pastel light green
    Color(0xffAEC6CF), // pastel blue
    Color(0xffF49AC2), // pastel magenta
    Color(0xffCFCFC4), // pastel grey
    Color(0xffFDFD96), // pastel light yellow
    Color(0xffDEA5A4), // pastel light red
    Color(0xff779ECB), // pastel medium blue
    Color(0xffB39EB5), // pastel violet
    Color(0xffFFB347), // pastel orange (light)
    Color(0xffC23B22), // pastel dark red
    Color(0xff03C03C), // pastel dark green
    Color(0xffFFEFDB), // pastel light orange
    Color(0xff966FD6), // pastel deep purple
    Color(0xff8B4513), // pastel brown
    Color(0xffD1E231), // pastel lime
    Color(0xffE6E6FA), // pastel lavender
    Color(0xffD8BFD8), // pastel thistle
    Color(0xffBC8F8F), // pastel rosy brown
    Color(0xffF4A460), // pastel sandy brown
    Color(0xff66CDAA), // pastel medium aquamarine
    Color(0xffFFB6C1), // pastel light pink
    Color(0xffFFA07A), // pastel light salmon
    Color(0xff20B2AA), // pastel light sea green
    Color(0xff87CEFA), // pastel light sky blue
  ];

  @override
  void onInit() {
    fetchShelfReadPercent('desc');
    super.onInit();
  }

  Future<void> fetchShelfReadPercent(String byOrder) async {
    try {
      isGRPLoading.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/shelvesRead/$byOrder'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        },
      );
      if (response.statusCode == 200) {
        print('genre shelf read 200');
        var stats = json.decode(response.body) as Map<String, dynamic>;
        shelfReadPerc
            .assignAll(stats.map((key, value) => MapEntry(key, value as int)));
      } else {
        print('genre shelf read errro' + response.body);

        Get.snackbar(
          'Oops',
          'Failed to fetch shelf stats',
        );
      }
    } catch (e) {
      print('genre shelf read catch');

      Get.snackbar('On Snap', e.toString());
    } finally {
      isGRPLoading.value = false;
    }
  }
}
