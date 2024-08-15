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
import '../user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_controller.dart';
import '../user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/like_dislike_feedback/like_dislike_controller.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NetworkManager());
    Get.lazyPut(() => FavController());
    //Get.put(AllCategoriesController(), permanent: true); //, permanent: true
    // Get.put(CafesController());
    Get.lazyPut(() => AllBooksController());
    // Get.put(CafeShelvesController());
    // Get.put(BookDetailsController());
    Get.lazyPut(() => ThemeController());
    Get.put(FeedbackController());
    Get.put(Like_dislikeController());
  }
}
