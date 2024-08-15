import 'dart:convert';

import 'package:booktaste/data/repositories/book_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../data/repositories/categories_repository.dart';
import '../../models/book.dart';
import '../../models/all_categories_model.dart';
import '../../utils/popups/loaders.dart';

class BookDetailsController extends GetxController {
  var isLoading = true.obs;
  var book = Book();
 

  Future<Book?> fetchBookDetails(String id) async {
    try {
      isLoading.value = true;
      var response = await BookRepository().getBookDetails(id);
      var bookData = json.decode(response.body);
      if (response.statusCode == 200) {
        print("not null book details " + jsonEncode(book));
        if (response.body.isNotEmpty) {
          book = Book.fromJson(bookData);
          return book;
        } else {
          isLoading.value = false;
          print('Faild to fetch book details');
          return book;
        }
      }
    } catch (e) {
      Loaders.errorSnackBar(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
    return null;
  }

}
