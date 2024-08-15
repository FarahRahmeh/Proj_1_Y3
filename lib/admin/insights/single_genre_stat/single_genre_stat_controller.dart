import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class ShelfStatsController extends GetxController {
  var shelfStat = 0.obs;
  var isStatsLoading = false.obs;

  @override
  void onInit() {
    fetchShelfStat('20');
    super.onInit();
  }

  Future<void> fetchShelfStat(String shelfId) async {
    try {
      isStatsLoading.value = true;
      final response = await http.get(
        Uri.parse('$baseUrl/shelfStats/$shelfId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        },
      );

      if (response.statusCode == 200) {
        shelfStat.value = int.parse(response.body);
      } else {
        Get.snackbar(
            'Oops', 'Failed to fetch shelf stat: ${response.reasonPhrase}');
        print('Failed to fetch shelf stat: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('On Snap', e.toString());
      print('Error occurred: $e');
    } finally {
      isStatsLoading.value = false;
    }
  }
}
