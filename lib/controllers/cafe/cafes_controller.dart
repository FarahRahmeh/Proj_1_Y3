import 'package:booktaste/models/cafe_model.dart';
import 'package:get/get.dart';

import '../../data/repositories/cafes_repository.dart';

class CafesController extends GetxController {
  var isLoading = true.obs;
  var cafesList = <Cafe>[];

  @override
  void onInit() {
    fetchAllCafes();
    super.onInit();
  }

  Future<List<Cafe?>> fetchAllCafes() async {
    try {
      isLoading.value = true;
      var allcafes = await CafesRepository.fechAllCafes();
      if (allcafes != null) {
        print("Cafés not null");
        cafesList = allcafes;
      }
    } finally {
      isLoading.value = false;
    }
    return cafesList;
  }
}
