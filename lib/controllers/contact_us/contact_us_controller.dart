import 'dart:convert';

import 'package:booktaste/common/features/contact_us/all_contact_us_view.dart';
import 'package:booktaste/data/repositories/contact_us_repository.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/models/contact_us_model.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class ContactController extends GetxController {
  var isLoading = false.obs;
  var contactUsMessages = <ContactUs>[].obs;
  var contact = ContactUs().obs;

  @override
  void onInit() {
    fetchAllContactUs();
    super.onInit();
  }

  //! Send Contact
  Future<void> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/contact'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
        body: {'message': message},
      );

      if (response.statusCode == 200) {
        fetchAllContactUs();
        print(response.body.toString());
        Get.off(() => AllContactUsPage());
        Get.snackbar("Success", "Message sent successfully!");
      } else {
        Get.snackbar("Error", "Failed to send message.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  //! Reply  Contact
  Future<void> replyToContactMessage(String message, String id) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/replyContact/$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
          'Connection': 'keep-alive',
          'Accept-Encoding': 'gzip, deflate, br',
        },
        body: {'message': message},
      );

      if (response.statusCode == 200) {
        fetchAllContactUs();
        Get.back();
        Get.snackbar("Success", "Reply sent successfully!");
      } else {
        Get.snackbar("Error", "Failed to send Reply.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
    }
  }

  //! All Contact Messages
  void fetchAllContactUs() async {
    try {
      isLoading.value = true;
      var allContactus = await ContactUsRepository().fetchAllContactUs();
      if (allContactus != null) {
        print("All contact us not null");
        contactUsMessages.value = allContactus;
      }
    } catch (e) {
      print("Error fetching contact us in controller : $e");
    } finally {
      isLoading.value = false;
    }
  }

  //! Message Details
  Future<ContactUs?> fetchContactDetails(String id) async {
    try {
      final response = await ContactUsRepository().getContactDetails(id);
      if (response.statusCode == 200) {
        return ContactUs.fromJson(json.decode(response.body));
      } else {
        Get.snackbar("Error", "Failed to load contact details");
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //! Delete Contact us
  Future<void> deleteContact(String id) async {
    try {
      final response = await ContactUsRepository().deleteContactUs(id);
      if (response.statusCode == 200) {
        fetchAllContactUs();
        Get.snackbar("Success", response.body.toString());
      } else {
        Get.snackbar("Error", "Failed to delete contact message.");
      }
    } catch (e) {
      Get.snackbar("On snap", "Catched error while delete contact message.");
    }
  }

  //! Update Contact us
  Future<void> updateContactMessage() async {
    try {
      final user = await isUser();
      final response = await ContactUsRepository().updateContactMessage(
          user == false
              ? contact.value.reply.toString()
              : contact.value.message.toString(),
          contact.value.id.toString());

      if (response.statusCode == 200) {
        fetchAllContactUs();
        print(response.body.toString());
        Get.back();
        Get.snackbar("Success", "updated successfully!");
      } else {
        print(response.body.toString());
        Get.snackbar("Error", "Failed to update message.");
      }
    } catch (e) {
      Get.snackbar("on Snap", "An error occurred: $e");
    }
  }
}
