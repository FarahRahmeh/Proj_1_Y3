import 'package:booktaste/models/book.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:get/get.dart';

import 'all_books_repositories.dart';

class AllBooksController extends GetxController {
  var isLoading = true.obs;
  var recommendIsLoading = true.obs;
  var booksList = <Book>[].obs;
  var recommendation = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllBooks();
    fetchRecommended();
  }

  Future<List<Book?>?> fetchAllBooks() async {
    try {
      isLoading.value = true;
      var allbooks = await AllBooksRepository.fechAllBooks();
      if (allbooks != null) {
        print("not null books");
        booksList.value = allbooks;
      }
      return allbooks;
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<Book?>?> fetchRecommended() async {
    try {
      recommendIsLoading.value = true;
      var recommended = await AllBooksRepository.fetchRedommendation();
      if (recommended != null) {
        print("not null recommendation books");
        recommendation.value = recommended;
      }
      return recommended;
    } catch (e) {

      print('recommeded catched');
      return null;
    } finally {
      recommendIsLoading.value = false;
    }
  }
}
