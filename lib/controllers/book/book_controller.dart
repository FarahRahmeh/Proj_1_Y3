import 'dart:convert';

import 'package:booktaste/data/repositories/book_repository.dart';
import 'package:get/get.dart';

import '../../data/repositories/categories_repository.dart';
import '../../models/book.dart';
import '../../user/user_home/all_categories_model.dart';
import '../../utils/popups/loaders.dart';

class BookDetailsController extends GetxController {
  var isLoading = true.obs;
  var book = Book.empty().obs;
  // @override
  // void onInit() {
  //   //fetchBookDetails(book.value.bookId);
  //   //fetchBookCover(imageUrl);
  //   super.onInit();
  // }

  void fetchBookDetails(String id) async {
    try {
      isLoading.value = true;
      var response = await BookRepository().getBookDetails(id);
      var bookData = json.decode(response.body);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          book.value = Book.fromJson(bookData);

          print("not null book detals " + book.toString());
        } else {
          isLoading.value = false;
          print('error with book details');
        }
      }
    } catch (e) {
      Loaders.errorSnackBAr(title: 'On Snap', message: e.toString());
      print(e.toString());
    }
  }
}
