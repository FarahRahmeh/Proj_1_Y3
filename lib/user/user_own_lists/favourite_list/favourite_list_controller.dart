import 'dart:convert';

import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/data/repositories/user_lists_repository.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/user/user_product_details/product_details_page.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../user_all_books/all_books_controller.dart';

class FavouriteController extends GetxController {
  var isLoading = true.obs;
  var favList = <Book>[].obs;
  var _userListRepository = UserListsRepository();

  @override
  void onInit() {
    super.onInit();
    fetchFavouriteList();
  }

  void fetchFavouriteList() async {
    try {
      isLoading.value = true;
      var favs = await UserListsRepository.fetchFavList();
      if (favs != null) {
        print("not null fav");
        favList.value = favs;
      }
    } catch (e) {
      print('error catched fav list ' + e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> checkIfIsFav(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fav/check/$id'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${GetStorage().read('TOKEN')}',
        },
      );

      if (response.statusCode == 200) {
        // response is true or false
        // Loaders.successSnackBar(
        //     title: 'Success', message: response.body.toString());
        print('fav check 200');
        return jsonDecode(response.body);
      } else {
        // Get.snackbar('Error', 'Failed to check is fav ');
        return false;
      }
    } catch (e) {
      // Get.snackbar('Error', e.toString());

      return false;
    }
  }

  Future<void> addToFavourite(String bookId) async {
    try {
      final response = await _userListRepository.addToFav(bookId);
      if (response.statusCode == 200) {
        print('fav adding  200');
        Loaders.customToast(message: response.body.toString());
        fetchFavouriteList();
        checkIfIsFav(bookId);
        // final ctrl = Get.put(AllBooksController());
        // ctrl.fetchAllBooks();
        // ctrl.fetchRecommended();
      } else {
        Get.snackbar('Error', 'Failed to add to fav');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
