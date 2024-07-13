import 'package:get/get.dart';

import '../../data/repositories/cafes_repository.dart';
import '../../models/cafe_shelf_model.dart';

class CafeShelvesController extends GetxController {
  var isLoading = true.obs;
  var cafeShelvesList = <CafeShelf>[].obs;

  // @override
  // void onInit() {

  //   var cafeId = Get.arguments;
  //   fetchCafeShelves(cafeId); // example cafeId
  //   super.onInit();
  // }

  void fetchCafeShelves(var cafeId) async {
    try {
      isLoading = true.obs;
      var shelves = await CafesRepository.fetchCafeShelves(cafeId);
      if (shelves != null) {
        cafeShelvesList.value = shelves;
        print(shelves);
      }
    } finally {
      print(cafeId);
      isLoading = false.obs;
    }
  }
}
