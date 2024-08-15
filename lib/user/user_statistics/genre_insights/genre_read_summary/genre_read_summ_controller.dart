import 'dart:convert';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class GenreReadSummaryController extends GetxController {
  var shelfReadSummary = <String, double>{}.obs;
  var isGRSLoading = false.obs;

  @override
  void onInit() {
    fetchShelfReadSummary('desc');
    super.onInit();
  }

  Future<void> fetchShelfReadSummary(String byOrder) async {
    try {
      isGRSLoading.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/shelvesInteract/$byOrder'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        },
      );
      if (response.statusCode == 200) {
        print('genre shelf summary 200');
        var stats = json.decode(response.body) as Map<String, dynamic>;
        shelfReadSummary.assignAll(
          stats.map((key, value) {
            if (value is int) {
              return MapEntry(key, value.toDouble());
            } else if (value is double) {
              return MapEntry(key, value);
            } else {
              throw Exception('Unexpected value type');
            }
          }),
        );
      } else {
        print('genre shelf summary errro' + response.body);

        Get.snackbar(
          'Oops',
          'Failed to fetch shelf stats',
        );
      }
    } catch (e) {
      print('genre shelf summary catch');

      Get.snackbar('On Snap', e.toString());
    } finally {
      isGRSLoading.value = false;
    }
  }
}
