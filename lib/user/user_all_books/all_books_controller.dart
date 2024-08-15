import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'all_books_repositories.dart';

class AllBooksController extends GetxController {
  var isLoading = true.obs;
  var booksList = <AllBooks>[].obs;
   var searchList = <AllBooks>[].obs;
  final TextEditingController searchController = TextEditingController();


  @override
  void onInit() {
    super.onInit();
    fetchAllBooks();
  }

  void fetchAllBooks() async {
    try {
      isLoading.value = true;
      var allbooks = await AllBooksRepository.fechAllBooks();
      if (allbooks != null) {
        print("not null books");
        booksList.value = allbooks;
      }
    } finally {
      isLoading.value = false;
    }
  }

  
  void addSearchToList(String value) {
    searchList.value = booksList.where((allBooksList) {
      return allBooksList.name.toLowerCase().contains(value.toLowerCase()) ||
          allBooksList.writer.toLowerCase().contains(value.toLowerCase()) ||
          // allBooksList.genre.toList().contains(value.toLowerCase()) ||
          allBooksList.id.toString().contains(value.toString());
    }).toList();
  }

  void clearSearch() {
    searchController.clear();
    addSearchToList("");
  }

}
