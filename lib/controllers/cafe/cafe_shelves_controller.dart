import 'dart:convert';

import 'package:get/get.dart';

import '../../data/repositories/cafes_repository.dart';
import '../../models/cafe_shelf_model.dart';

class CafeShelvesController extends GetxController {
  var isLoading = true.obs;
  var cafeShelvesList = <CafeShelf?>[];

  Future<List<CafeShelf?>?> fetchCafeShelves(var cafeId) async {
    try {
      isLoading = true.obs;
      var _cafeRepository = CafesRepository();
      var response = await _cafeRepository.fetchCafeShelves(cafeId);

      var cafeShleves = response;
      //cafeshlevesFromJson(cafeShleves);
      if (cafeShleves != null) {
        cafeShelvesList = cafeShleves;
        return cafeShleves;
      }
    } finally {
      print(cafeId);
      isLoading = false.obs;
    }
    return null;
  }
}
