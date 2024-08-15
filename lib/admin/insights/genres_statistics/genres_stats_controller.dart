import 'dart:convert';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class GenreStatsController extends GetxController {
  var shelfStats = <String, int>{}.obs;
  var isStatsLoading = false.obs;
  var touchedIndex = (-1).obs;
  @override
  void onInit() {
    fetchShelfStats('desc');
    super.onInit();
  }

  Future<void> fetchShelfStats(String byOrder) async {
    try {
      isStatsLoading.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/shelvesStats/$byOrder'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        },
      );
      if (response.statusCode == 200) {
        var stats = json.decode(response.body) as Map<String, dynamic>;
        shelfStats
            .assignAll(stats.map((key, value) => MapEntry(key, value as int)));
      } else {
        Get.snackbar(
          'Oops',
          'Failed to fetch shelf stats',
        );
        print('Failed to fetch shelf stats: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('On Snap', e.toString());
    } finally {
      isStatsLoading.value = false;
    }
  }
}
