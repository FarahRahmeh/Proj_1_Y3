import 'package:booktaste/models/book.dart';
import 'package:booktaste/user/user_own_lists/read_later_list/read_later_model.dart';
import 'package:booktaste/user/user_own_lists/reading_list/read_book_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../utils/constans/api_constans.dart';

class UserListsRepository extends GetxController {
//! Favourite list
  static Future<List<Book>?> fetchFavList() async {
    final response = await http.get(Uri.parse('$baseUrl/myFav'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success fav list");
      var books = response.body;
      return bookFromJson(books);
    } else {
      print(response.statusCode);
      return null;
    }
  }

//! History
  static Future<List<Book>?> fetchHistory() async {
    final response = await http.get(Uri.parse('$baseUrl/myRH'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success fav list");
      var books = response.body;
      return bookFromJson(books);
    } else {
      print(response.statusCode);
      return null;
    }
  }

//! Current Reading
  static Future<List<ReadBook>?> fetchReadList() async {
    final response = await http.get(Uri.parse('$baseUrl/myRL'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success fav list");
      var books = response.body;
      return readBookFromJson(books);
    } else {
      print(response.statusCode);
      return null;
    }
  }

//! ReadLater
  static Future<List<ReadLater>?> fetchReadLater(String orderBy) async {
    final response =
        await http.get(Uri.parse('$baseUrl/myRLL/$orderBy'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success read later list");
      var books = response.body;
      return readLaterFromJson(books);
    } else {
      print(response.statusCode);
      return null;
    }
  }

//! unlocked list
  static Future<List<Book>?> fetchUnlocked() async {
    final response = await http.get(Uri.parse('$baseUrl/myUnlocked'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    if (response.statusCode == 200) {
      print("success unlocked list");
      var books = response.body;
      return bookFromJson(books);
    } else {
      print(response.statusCode);
      return null;
    }
  }

  //! Add to favourite
  Future<http.Response> addToFav(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/addToFav/$id'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      },
    );
    return response;
  }

//! Add to Read Later
  Future<http.Response> addToReadLater(String priority, String id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/readLater/$id/$priority'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    });
    return response;
  }

  //! Add to History
  Future<http.Response> addToHistory(String StartedAt, String totReadTime,
      String finishedAt, String id) async {
    var body = {
      'started_at': StartedAt,
      'total_read_time': totReadTime,
      'finished_at': finishedAt,
    };
    final response = await http.post(
      Uri.parse('$baseUrl/addToBh/$id'),
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
      body: body,
    );
    return response;
  }
}
