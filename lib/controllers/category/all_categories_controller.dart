import 'package:get/get.dart';

import '../../data/repositories/categories_repository.dart';
import '../../user/user_home/all_categories_model.dart';

class AllCategoriesController extends GetxController {
  var isLoading = true.obs;
  var allCategoriesList = <AllCategories>[].obs;

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
}
