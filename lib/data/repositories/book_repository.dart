import 'dart:convert';

import 'package:booktaste/utils/constans/images.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../utils/constans/api_constans.dart';
import 'package:http/http.dart' as http;

class BookRepository extends GetxController {
  var headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
    'Connection': 'keep-alive',
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
    final response =
        await http.get(Uri.parse('$baseUrl/bookDetails/$id'), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    });
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
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
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
    print(jsonEncode(bookData) + cover + book);

    return await http.Response.fromStream(response);
  }

  Future<http.Response> updateBook({
    required String bookId,
    required String title,
    required String author,
    required String publishedAt,
    required String points,
    required String pagesNum,
    required String language,
    required String summary,
    required List<String> genres,
    required int isNovel,
    required int isLocked,
    required String cover,
    required String book,
  }) async {
    final bookData = {
      'name': title,
      'writer': author,
      'published_at': publishedAt,
      'points': int.tryParse(points) ?? 0,
      'pages_num': int.tryParse(pagesNum) ?? 0,
      'lang': language
          .toString(), //'language': language.isEmpty? 'Unknown': language,
      'summary': summary,
      'is_novel': isNovel.toString(),
      'is_locked': isLocked.toString(),
    };
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
      'Connection': 'keep-alive',
      'Accept-Encoding': 'gzip, deflate, br',
    };
    for (int i = 0; i < genres.length; i++) {
      bookData['genre[$i]'] = genres[i];
    }

    var request = http.MultipartRequest(
        'POST', Uri.parse('$baseUrl/updateBook/$bookId'))
      ..fields
          .addAll(bookData.map((key, value) => MapEntry(key, value.toString())))
      ..headers.addAll(headers);

    // if (cover.isNotEmpty) {
    //   request.files.add(await http.MultipartFile.fromPath('cover', cover));
    // }

    // if (book.isNotEmpty) {
    //   request.files.add(await http.MultipartFile.fromPath('book', book));
    // }
    if (cover.isNotEmpty && cover != Images.defaultBookCover) {
      try {
        request.files.add(await http.MultipartFile.fromPath('cover', cover));
      } catch (e) {
        print('Cover path error: $e');
      }
    }

    if (book.isNotEmpty) {
      //&& !book.startsWith('/books')
      try {
        request.files.add(await http.MultipartFile.fromPath('book', book));
      } catch (e) {
        print('Book path error: $e');
      }
    }
    var response = await request.send();
    print(jsonEncode(bookData) + cover + book);

    return await http.Response.fromStream(response);
  }

  // Future<http.Response> changeBookRequestState(String id, String state) async {
  //   final response =
  //       await http.get(Uri.parse('$baseUrl/approve/$id/$state'), headers: {
  //     'Accept': 'application/json',
  //     'Content-Type': 'application/json',
  //     'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
  //     'Connection': 'keep-alive',
  //   });
  //   return response;
  // }

  //! insights

  Future<http.Response> fetchPopularBooks(String order) async {
    final response = await http.get(
      Uri.parse('$baseUrl/popBooks/$order'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );
    return response;
  }

  Future<http.Response> fetchRatedBooks(String byOrder) async {
    final response = await http.get(
      Uri.parse('$baseUrl/byRate/$byOrder'),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br',
      },
    );
    return response;
  }
}
