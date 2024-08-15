import 'package:booktaste/user/user_book_request/book_request_model.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserBookRequestController extends GetxController {
  var requests = <UserBookRequest>[].obs; // Observable list
  var isLoading = true.obs;
  @override
  void onInit() {
    fetchBookRequests();
    super.onInit();
  }

  //!  All Request
  Future<void> fetchBookRequests() async {
    isLoading.value = true;
    final response = await http.get(
      Uri.parse('$baseUrl/myRequestsList'),
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
      requests.value = bookRequestFromJson(response.body);
    } else {
      isLoading.value = false;
      Get.snackbar("Error", "Failed to load data");
    }
  }

  //! Request Details
  Future<UserBookRequest?> fetchRequestDetails(String requestId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/userRequestDetails/$requestId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );
      if (response.statusCode == 200) {
        return UserBookRequest.fromJson(json.decode(response.body));
      } else {
        Get.snackbar("Error", "Failed to load request details");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //! Delete Request ( only if it is in review state )
  Future<void> deleteRequest(String requestId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/deleteRequest/$requestId'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );

      if (response.statusCode == 200) {
        // Remove the request from the local list
        requests.removeWhere((request) => request.id == requestId);
        Get.snackbar("Success", response.body.toString());
        fetchBookRequests();
      } else {
        Get.snackbar("Error", "Failed to delete request.");
      }
    } catch (e) {
      Get.snackbar("On snap", "Catched error while delete request.");
    }
  }
}
