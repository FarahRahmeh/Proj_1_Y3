import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../user/user_quotes/journal/journal_model.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class JournalRepository extends GetxController {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    'Connection': 'keep-alive',
  };
  // //! Delete quoteBook
  Future<http.Response> deleteJournal(String id, bool only) async {
    final response = await http.delete(
      Uri.parse(
          only ? '$baseUrl/deleteQb/only/$id' : '$baseUrl/deleteQb/all/$id'),
      headers: headers,
    );
    return response;
  }

  //! Add quotebook
  Future<http.Response> addJournal({
    required String journalName,
    String? bio,
    String? year,
    String? image,
  }) async {
    final journalData = {
      'name': journalName,
      if (bio != null && bio.isNotEmpty) 'bio': bio,
      if (year != null && year.isNotEmpty) 'year': year,
      if (image != null && image.isNotEmpty) 'image_name': image,
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/newQuotebook'))
          ..fields.addAll(
              journalData.map((key, value) => MapEntry(key, value.toString())))
          ..headers.addAll(headers);

    if (image != null && image.isNotEmpty) {
      try {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      } catch (e) {
        print('journal Image upload error: $e');
      }
    }
    var response = await request.send();

    return await http.Response.fromStream(response);
  }


  Future<http.Response> updateJournal({
    required String id,
    required String journalName,
    String? bio,
    String? year,
    String? image,
  }) async {
    final journalData = {
      'name': journalName,
      if (bio != null && bio.isNotEmpty) 'bio': bio,
      if (year != null && year.isNotEmpty) 'year': year,
      if (image != null && image.isNotEmpty) 'image_name': image,
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/updateQb/$id'))
          ..fields.addAll(
              journalData.map((key, value) => MapEntry(key, value.toString())))
          ..headers.addAll(headers);

    if (image != null && image.isNotEmpty) {
      try {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      } catch (e) {
        print('journal Image upload error: $e');
      }
    }
    var response = await request.send();

    return await http.Response.fromStream(response);
  }

  Future<List<Journal>?> fetchAllJournals() async {
    final response = await http.get(Uri.parse('$baseUrl/myQbs'), headers: {
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success all journals");
      var journals = response.body;
      return journalFromJson(journals);
    } else {
      print('${response.statusCode.toString()}' + 'all journals repo error');
      return null;
    }
  }

  Future<List<Quote>?> fetchJournalQuotes(int journalId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/quotebookQL/$journalId'), headers: {
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      var quotes = response.body;
      return QuoteFromJson(quotes);
    } else {
      throw Exception(
          'Failed to load journal quotes : ${response.statusCode}');
    }
  }
}
