import 'package:booktaste/data/repositories/user_lists_repository.dart';
import 'package:booktaste/user/user_own_lists/reading_list/read_book_model.dart';
import 'package:get/get.dart';

class ReadingListController extends GetxController {
  var isLoading = true.obs;
  var readingList = <ReadBook>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchReadingList();
  }

  void fetchReadingList() async {
    try {
      isLoading.value = true;
      var history = await UserListsRepository.fetchReadList();
      if (history != null) {
        print("not null reading list ");
        readingList.value = history;
        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      print('error catched reading list ' + e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }
}
