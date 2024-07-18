import 'package:booktaste/controllers/cafe/cafe_shelves_controller.dart';
import 'package:booktaste/controllers/cafe/cafes_controller.dart';
import 'package:booktaste/controllers/category/all_categories_controller.dart';
import 'package:booktaste/controllers/favourites/favourite_controller.dart';
import 'package:booktaste/controllers/theme/theme_controller.dart';
import 'package:booktaste/data/services/network_manager.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:get/get.dart';

import '../controllers/book/book_controller.dart';
import '../data/repositories/book_repository.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    Get.put(FavController());
    //Get.put(AllCategoriesController(), permanent: true); //, permanent: true
    // Get.put(CafesController());
    //   Get.put(AllBooksController());
    // Get.put(CafeShelvesController());
    // Get.put(BookDetailsController());
    Get.put(ThemeController());
  }
}
