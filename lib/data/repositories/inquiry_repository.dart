import 'package:booktaste/models/inquiry_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class InquiriesRepository extends GetxController {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    'Connection': 'keep-alive',
  };

  //! All book Inquiries
  Future<List<Inquiry>?> fetchAllBookInquiries(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/bookInquiries/$id'), headers: {
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success all book inquires ");
      var inquiries = response.body;
      return inquiryFromJson(inquiries);
    } else {
      print('${response.statusCode.toString()}' + 'all inquires  repo error');
      return null;
    }
  }

  Future<List<Inquiry>?> fetchUserInquiries() async {
    final response =
        await http.get(Uri.parse('$baseUrl/myInquiries'), headers: {
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    });
    if (response.statusCode == 200) {
      print("success  user inquires ");
      var inquiries = response.body;
      return inquiryFromJson(inquiries);
    } else {
      print('${response.statusCode.toString()}' +
          'all user inquires  repo error');
      return null;
    }
  }

  //! Not Replied Inquiries
  Future<List<Inquiry>?> fetchNotRepliedInquiries(String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/notRepliedInq/$id'), headers: {
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    });
    if (response.statusCode == 200) {
      print("success all book inquires not replied ");
      var inquiries = response.body;
      return inquiryFromJson(inquiries);
    } else {
      print('${response.statusCode.toString()}' +
          'all not replied inquires  repo error');
      return null;
    }
  }

// //
//   //! Delete Inquiry
  Future<http.Response> deleteInquiry(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/deleteInquiry/$id'),
      headers: headers,
    );
    return response;
  }

// //
// //! update Inquiry
  Future<http.Response> updateInquiry(String message, String id) async {
    final response =
        await http.post(Uri.parse('$baseUrl/updateInquiry/$id'), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
    }, body: {
      'message': message
    });
    return response;
  }
}
