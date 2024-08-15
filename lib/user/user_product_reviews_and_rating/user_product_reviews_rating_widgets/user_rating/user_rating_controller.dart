
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'user_rating_model.dart';
import 'user_rating_repositories.dart';

class RateController extends GetxController {
  var isLoading = true.obs;
  var stars = 0.0.obs;
  var rating = 0.0.obs;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadUserRating();
  }

  void updateRating(double newRating) {
    rating.value = newRating;
  }

  void fetchrate(int  bookid) async {
    try {
      isLoading.value = true;
      var rate = await RateRepository.submitRating(bookid, rating.value);
      if (rate != null) {
        stars.value = rate.stars;
        saveUserRating(rate.stars);
        print(stars);
      }
    } catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void saveUserRating(double rating) {
    box.write('user_rating', rating);
  }

  void loadUserRating() {
    double? savedRating = box.read('user_rating');
    if (savedRating != null) {
      stars.value = savedRating;
    }
  }
}
