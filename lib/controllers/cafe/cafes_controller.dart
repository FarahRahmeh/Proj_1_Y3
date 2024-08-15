import 'package:booktaste/models/book.dart';
import 'package:booktaste/models/cafe_model.dart';
import 'package:get/get.dart';

import '../../data/repositories/cafes_repository.dart';

class CafesController extends GetxController {
  var isLoading = true.obs;
  var cafesList = <Cafe>[];
  var isBooksLoading = true.obs;
  var cafeBooks = <Book>[].obs;

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

  void fetchCafeBooks(String id) async {
    try {
      isBooksLoading.value = true;
      var response = await CafesRepository.getCafeBooks(id);
      var books = bookFromJson(response.body);

      if (books != null) {
        print("not null all books cafe");
        cafeBooks.value = books;
      }
    } finally {
      isBooksLoading.value = false;
    }
  }
}
