import 'package:booktaste/common/features/book_inquiry/book_inquiry_page.dart';
import 'package:booktaste/data/repositories/inquiry_repository.dart';
import 'package:booktaste/models/inquiry_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../data/services/role.manager.dart';
import '../../utils/constans/api_constans.dart';

class InquiryController extends GetxController {
  var isNotRepliedLoading = false.obs;
  var isLoading = false.obs;
  var isUserInqLoading = false.obs;
  var inquiry = Inquiry().obs;
  var bookId = ''.obs;
  var bookInquiriesList = <Inquiry>[].obs;
  var userInquiriesList = <Inquiry>[].obs;
  var notRepliedInqs = <Inquiry>[].obs;

  @override
  void onInit() {
    fetchBookInquiries(bookId.toString());
    fetchUserInquiries();
    super.onInit();
  }

  Future<bool> isUserInquiry(Inquiry inquiry) async {
    return userInquiriesList.any((userInquiry) => userInquiry.id == inquiry.id);
  }

  //! All Inquiries Messages
  Future<List<Inquiry?>?> fetchBookInquiries(String id) async {
    try {
      isLoading.value = true;
      var inquiries = await InquiriesRepository().fetchAllBookInquiries(id);
      if (inquiries != null) {
        print("All inquires not null");
        bookInquiriesList.value = inquiries;
        return inquiries;
      }
    } catch (e) {
      print("Error fetching inquires in controller : $e");
      return null;
    } finally {
      isLoading.value = false;
      return null;
    }
  }

  //! All Inquiries Not replied
  Future<List<Inquiry?>?> fetchNotRepliedInquiries(String id) async {
    try {
      isNotRepliedLoading.value = true;
      var inquiries = await InquiriesRepository().fetchNotRepliedInquiries(id);
      if (inquiries != null) {
        print("All not replied inquires not null");
        notRepliedInqs.value = inquiries;
        return inquiries;
      }
    } catch (e) {
      print("Error fetching not replied inquires in controller : $e");
      return null;
    } finally {
      isNotRepliedLoading.value = false;
      return null;
    }
  }

  //! User Inquiries
  Future<void> fetchUserInquiries() async {
    try {
      isUserInqLoading.value = true;
      var inquiries = await InquiriesRepository().fetchUserInquiries();
      if (inquiries != null) {
        print("user inquires not null");
        userInquiriesList.value = inquiries;
      }
    } catch (e) {
      print("Error fetching user inquires in controller : $e");
    } finally {
      isUserInqLoading.value = false;
    }
  }

  // //! Send
  Future<void> sendInquiry(String message, String id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/inquiry/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
        body: {'message': message},
      );
      if (response.statusCode == 200) {
        fetchBookInquiries(bookId.toString());
        fetchUserInquiries();
        Get.off(() => BookInquiriesPage(
              bookId: id,
            ));
        // Get.back();
        print(response.body.toString());
        Get.snackbar("Success", "Message Inq sent successfully!");
      } else {
        Get.snackbar("Error", "Failed to send message Inq.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error Inq occurred: $e");
    }
  }

  // //! Reply
  Future<void> replyToInquiry(String message, String inqId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/replyInquiry/$inqId'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
        body: {'message': message},
      );

      if (response.statusCode == 200) {
        fetchBookInquiries(bookId.toString());
        Get.back();
        Get.snackbar("Success", "Reply sent successfully!");
      } else {
        Get.snackbar("Error", "Failed to send Reply.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  // //! Delete
  Future<void> deleteInquiry(String id) async {
    try {
      final response = await InquiriesRepository().deleteInquiry(id);
      if (response.statusCode == 200) {
        fetchBookInquiries(bookId.toString());
        fetchUserInquiries();
        Get.back();
        Get.snackbar("Success", response.body.toString());
      } else {
        Get.snackbar("Error", "Failed to delete inq message.");
      }
    } catch (e) {
      Get.snackbar("On snap", "Catched error while delete inq message.");
    }
  }

  // //! Update
  Future<void> updateInquiry() async {
    try {
      final user = await isUser();
      final response = await InquiriesRepository().updateInquiry(
          user == false
              ? inquiry.value.reply.toString()
              : inquiry.value.inquiry.toString(),
          inquiry.value.id.toString());

      if (response.statusCode == 200) {
        fetchUserInquiries();
        fetchBookInquiries(bookId.toString());
        print(response.body.toString());
        Get.back();
        Get.snackbar("Success", "updated successfully!");
      } else {
        print(response.body.toString());
        Get.snackbar("Error", "Failed to update inquiry.");
      }
    } catch (e) {
      Get.snackbar("on Snap", "An error occurred: $e");
    }
  }
}
