import 'package:booktaste/models/contact_us_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class ContactUsRepository extends GetxController {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    'Connection': 'keep-alive',
  };

  //! All Contact Messages
  Future<List<ContactUs>?> fetchAllContactUs() async {
    final response = await http.get(Uri.parse('$baseUrl/allContact'), headers: {
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success all contact us");
      var contactUs = response.body;
      return contactUsFromJson(contactUs);
    } else {
      print('${response.statusCode.toString()}' + 'all contact us repo error');
      return null;
    }
  }

  //! Contact Details
  Future<http.Response> getContactDetails(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/contactDet/$id'), headers: headers);
    return response;
  }

//
  //! Delete Contact
  Future<http.Response> deleteContactUs(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/deleteContact/$id'),
      headers: headers,
    );
    return response;
  }

//
//! update contact message
  Future<http.Response> updateContactMessage(String message, String id) async {
    final response =
        await http.post(Uri.parse('$baseUrl/updateContact/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
    }, body: {
      'message': message
    });
    return response;
  }
}
