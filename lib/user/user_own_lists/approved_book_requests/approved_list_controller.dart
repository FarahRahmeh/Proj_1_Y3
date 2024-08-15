import 'package:booktaste/models/book.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ApprovedListController extends GetxController {
  var isLoading = true.obs;
  var approvedList = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchApprovedList();
  }

  void fetchApprovedList() async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/requestsCafe'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );
      if (response.statusCode == 200) {
        isLoading.value = false;
        approvedList.value = bookFromJson(response.body);
      } else {
        isLoading.value = false;
        print('Failed to fetch approved list user ..');
      }
    } catch (e) {
      print('error catched approved list ' + e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
