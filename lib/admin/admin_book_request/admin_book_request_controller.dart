import 'package:booktaste/admin/admin_book_request/admin_book_request_model.dart';
import 'package:booktaste/admin/admin_book_request/admin_book_request_view.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminBookRequestController extends GetxController {
  var isLoading = false.obs;
  var adminBookRequests = <AdminBookRequest>[].obs;
  var approve = 'accept'.obs;

  void setApprove(String value) {
    approve.value = value;
    update();
  }

  @override
  void onInit() {
    fetchAdminBookRequests();
    super.onInit();
  }

//! fetching all request
  void fetchAdminBookRequests() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('$baseUrl/requestL'),
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

        adminBookRequests.value = adminBookRequestFromJson(response.body);
      } else {
        isLoading.value = false;
        print('Failed to fetch admin book requests');
      }
    } catch (e) {
      isLoading.value = false;
      // Handle exception
      print('Exception occurred: $e');
    }
  }

  //! accept or not accept
  void changeBookRequestState(String id, String approve) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/approve/$id/$approve'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );
      if (response.statusCode == 200) {
        Loaders.successSnackBar(
            title: 'success ', message: response.body.toString());
        fetchAdminBookRequests();
        final ctrl = Get.put(AllBooksController());
        ctrl.fetchAllBooks();
        Get.off(() => AdminBookRequestsView());
        print('request change state 200');
      } else {
        // Handle error
        print('Failed to change admin book request state');
      }
    } catch (e) {
      // Handle exception
      print('Exception occurred book request state: $e');
    }
  }

//! show request details
  Future<AdminBookRequest?> fetchRequestDetails(String id) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/adminRequestDetails/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
      );
      if (response.statusCode == 200) {
        var book = AdminBookRequest.fromJson(json.decode(response.body));
        return book;
      } else {
        print('Failed to fetch admin book request details');
        return null;
      }
    } catch (e) {
      print('Exception occurred admin book request details : $e');
      return null;
    }
  }
}
