import 'package:booktaste/models/book.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../utils/constans/api_constans.dart';

class AllBooksRepository extends GetxController {
  static Future<List<Book>?> fechAllBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/allBooks'), headers: {
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    });
    if (response.statusCode == 200) {
      print("success all books");
      var books = response.body;
      return bookFromJson(books);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  static Future<List<Book>?> fetchRedommendation() async {
    //! Book not all books
    final response = await http.get(Uri.parse('$baseUrl/recommend'), headers: {
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    });
    if (response.statusCode == 200) {
      print("success recommend books");
      var books = response.body;
      return bookFromJson(books);
    } else {
      print(response.statusCode);
      return null;
    }
  }
}
