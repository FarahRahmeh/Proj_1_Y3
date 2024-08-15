import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:get/get.dart';

import '../../data/repositories/categories_repository.dart';
import '../../models/all_categories_model.dart';

class AllCategoriesController extends GetxController {
  var isLoading = true.obs;
  var allCategoriesList = <AllCategories>[].obs;
  var categoryBooks = <AllBooks>[].obs;
  var isCaBooksLoading = true.obs;

  @override
  void onInit() {
    fetchAllCategories();
    super.onInit();
  }

  void fetchAllCategories() async {
    try {
      isLoading.value = true;
      var allCategories = await AllCategoriesRepository.fechAllCategories();
      if (allCategories != null) {
        print("not null categories");
        allCategoriesList.value = allCategories;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<AllBooks?>?> fetchCategoryBooks(String id) async {
    try {
      isCaBooksLoading.value = true;
      var response = await AllCategoriesRepository.getCategoryBooks(id);
      var genreBooks = allBooksFromJson(response.body);

      if (genreBooks != null) {
        print("not null categories");
        categoryBooks.value = genreBooks;
      }
      return genreBooks;
    } finally {
      isCaBooksLoading.value = false;
    }
  }
}
// class AllCategoriesController extends GetxController {
//   var isLoading = true.obs;
//   var allCategoriesList = <AllCategories>[].obs;
//   var categoryBooks = <AllBooks>[].obs;
//   var isCaBooksLoading = true.obs;

//   // Private flag to prevent multiple fetches
//   final _isFetching = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     fetchAllCategories();
//   }

//   void fetchAllCategories() async {
//     try {
//       isLoading.value = true;
//       var allCategories = await AllCategoriesRepository.fechAllCategories();
//       if (allCategories != null) {
//         allCategoriesList.value = allCategories;
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> fetchCategoryBooks(String id) async {
//     if (_isFetching.value) return;
//     _isFetching.value = true;

//     try {
//       isCaBooksLoading.value = true;
//       var response = await AllCategoriesRepository.getCategoryBooks(id);
//       var genreBooks = allBooksFromJson(response.body);

//       if (genreBooks != null) {
//         categoryBooks.value = genreBooks;
//       }
//     } finally {
//       _isFetching.value = false;
//       isCaBooksLoading.value = false;
//     }
//   }
// }
