import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<String> bookListsFromJson(String str) =>
    List<String>.from(json.decode(str).map((x) => x));

String bookListsToJson(List<String> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x)));

class BookListsController extends GetxController {
  var bookLists = <String>[].obs; // Observable list to store the response
  var isLoading = true.obs; // Observable to manage loading state
  var errorMessage = ''.obs; // Observable to manage error messages

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  Future<void> fetchBookLists(String id) async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse('$baseUrl/bookL/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );

      if (response.statusCode == 200) {
        bookLists.value = bookListsFromJson(response.body);
      } else {
        errorMessage.value = 'Failed to load data';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading(false);
    }
  }
}
