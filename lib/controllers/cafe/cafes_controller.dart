import 'package:booktaste/models/cafe_model.dart';
import 'package:get/get.dart';

import '../../data/repositories/cafes_repository.dart';

class CafesController extends GetxController {
  var isLoading = true.obs;
  var cafesList = <Cafes>[].obs;

  @override
  void onInit() {
    fetchAllCafes();
    super.onInit();
  }

  void fetchAllCafes() async {
    try {
      isLoading(true);
      var allcafes = await CafesRepository.fechAllCafes();
      if (allcafes != null) {
        print("Cafés not null");
        cafesList.value = allcafes;
      }
    } finally {
      isLoading(false);
    }
  }
}
