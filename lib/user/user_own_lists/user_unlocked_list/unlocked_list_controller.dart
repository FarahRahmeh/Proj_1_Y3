import 'package:booktaste/data/repositories/user_lists_repository.dart';
import 'package:booktaste/models/book.dart';
import 'package:get/get.dart';

class UnlockedListController extends GetxController {
  var isLoading = true.obs;
  var unlockedList = <Book>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUnlockedList();
  }

  void fetchUnlockedList() async {
    try {
      isLoading.value = true;
      var books = await UserListsRepository.fetchUnlocked();
      if (books != null) {
        print("not null unlocked list ");
        unlockedList.value = books;
        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      print('error catched unlocked list ' + e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
