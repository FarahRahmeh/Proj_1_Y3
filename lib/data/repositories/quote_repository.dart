
import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class QuoteRepository extends GetxController {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    'Connection': 'keep-alive',
  };
  //! Delete book
  Future<http.Response> deleteQuote(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/deleteQuote/$id'),
      headers: headers,
    );
    return response;
  }

  //! Add quote
  Future<http.Response> addQuote({
    required String quoteText,
    String? thoughts,
    String? author,
    String? sourceId,
    String? bookTitle,
    String? page,
    String? image,
    String? fav,
  }) async {
    final quoteData = {
      'quote': quoteText,
      if (sourceId != null && sourceId.isNotEmpty) 'source_id': sourceId,
      if (bookTitle != null && bookTitle.isNotEmpty) 'name': bookTitle,
      if (author != null && author.isNotEmpty) 'writer': author,
      if (thoughts != null && thoughts.isNotEmpty) 'my_thoughts': thoughts,
      if (fav != null && fav.isNotEmpty) 'in_fav': fav,
      if (page != null && page.isNotEmpty) 'page_num': page,
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/quote'))
      ..fields.addAll(
          quoteData.map((key, value) => MapEntry(key, value.toString())))
      ..headers.addAll(headers);

    if (image != null && image.isNotEmpty) {
      try {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      } catch (e) {
        print('Image upload error: $e');
      }
    }
    print('adding quote request :' + "${request}");
    var response = await request.send();

    return await http.Response.fromStream(response);
  }

  Future<List<Quote>?> fetchAllQuotes() async {
    final response = await http.get(Uri.parse('$baseUrl/myQL'), headers: {
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success all quotes");
      var quotes = response.body;
      return QuoteFromJson(quotes);
    } else {
      print('${response.statusCode.toString()}' + 'all quotes repo error');
      return null;
    }
  }

  //! Update Quote
  Future<http.Response> updateQuote({
    required int quoteId,
    required String quoteText,
    String? thoughts,
    String? author,
    String? sourceId,
    String? bookTitle,
    String? page,
    String? image,
    String? fav,
  }) async {
    final quoteData = {
      'quote': quoteText,
      if (sourceId != null && sourceId.isNotEmpty) 'source_id': sourceId,
      if (bookTitle != null && bookTitle.isNotEmpty) 'name': bookTitle,
      if (author != null && author.isNotEmpty) 'writer': author,
      if (thoughts != null && thoughts.isNotEmpty) 'my_thoughts': thoughts,
      if (fav != null && fav.isNotEmpty) 'in_fav': fav,
      if (page != null && page.isNotEmpty) 'page_num': page,
    };

    // final response = await http.post(
    //   Uri.parse('$baseUrl/updateQuote/$quoteId'),
    //   headers: {
    //     'Accept': 'application/json',
    //     'Content-Type': 'application/json',
    //     'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    //     'Connection': 'keep-alive',
    //     'Accept-Encoding': 'gzip, deflate, br',
    //   },
    //   body: jsonEncode(quote),
    // );
    // return response;
    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/updateQuote/$quoteId'))
      ..fields.addAll(
          quoteData.map((key, value) => MapEntry(key, value.toString())))
      ..headers.addAll(headers);

    if (image != null && image.isNotEmpty) {
      try {
        request.files.add(await http.MultipartFile.fromPath('image', image));
      } catch (e) {
        print('Image upload error: $e');
      }
    }
    print('updating quote request :' + "${request}");
    var response = await request.send();

    return await http.Response.fromStream(response);
  }
}
