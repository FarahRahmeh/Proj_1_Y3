import 'dart:convert';

import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/data/services/token_manager.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/models/cafe_model.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../models/cafe_shelf_model.dart';
import '../../models/all_categories_model.dart';
import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class BookRepository extends GetxController {
  // Future<void> getBookCover(String imageUrl) async {
  //   await http.get(
  //     Uri.parse('$baseUrl/$imageUrl'), // covers/$url
  //   );
  //   //return response;
  // }
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('TOKEN')}'
  };
  //! Delete book
  Future<http.Response> deleteBook(String id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/deleteBook/$id'), headers: headers, // covers/$url
    );
    return response;
  }

  //! book details
  Future<http.Response> getBookDetails(String id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/bookDetails/$id'), // covers/$url
    );
    return response;
  }

  Future<http.Response> addBook({
    required String title,
    required String author,
    required String publishedAt,
    required String points,
    required String pagesNum,
    required String language,
    required String summary,
    required List<String> genres,
    required bool isNovel,
    required bool isLocked,
    required String cover,
    required String book,
  }) async {
    final bookData = {
      'name': title,
      'writer': author,
      'published_at': publishedAt,
      'points': int.tryParse(points) ?? 0,
      'pages': int.tryParse(pagesNum) ?? 0,
      'lang': language
          .toString(), //'language': language.isEmpty? 'Unknown': language,
      'summary': summary,

      'is_novel': isNovel.toString(),
      'locked': isLocked.toString(),
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}'
    };
    for (int i = 0; i < genres.length; i++) {
      bookData['genre[$i]'] = genres[i];
    }

    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/addBook'))
      ..fields
          .addAll(bookData.map((key, value) => MapEntry(key, value.toString())))
      ..headers.addAll(headers);

    if (cover.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('cover', cover));
    }

    if (book.isNotEmpty) {
      request.files.add(await http.MultipartFile.fromPath('book', book));
    }

    var response = await request.send();
    // if (isUser() == true) {
    //   getBookRequestData(
    //       title: title,
    //       author: author,
    //       publishedAt: publishedAt,
    //       points: points,
    //       pagesNum: pagesNum,
    //       language: language,
    //       summary: summary,
    //       genres: genres,
    //       isNovel: isNovel,
    //       isLocked: isLocked,
    //       cover: cover,
    //       book: book);
    // }

    return await http.Response.fromStream(response);
    //~ The response is the book request from the users
  }
}
