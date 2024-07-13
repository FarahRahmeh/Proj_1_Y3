import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:get/get.dart';

import 'all_books_repositories.dart';

class AllBooksController extends GetxController {
  var isLoading = true.obs;
  var booksList = <AllBooks>[].obs;

  @override
  void onInit() {
    fetchAllBooks();
    super.onInit();
  }

  void fetchAllBooks() async {
    try {
      isLoading(true);
      var allbooks = await AllBooksRepository.fechAllBooks();
      if (allbooks != null) {
        print("not null books");
        booksList.value = allbooks;
      }
    } finally {
      isLoading(false);
    }
  }
}
