import 'package:booktaste/data/repositories/user_lists_repository.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class HistoryListController extends GetxController {
  var isLoading = true.obs;
  var historyList = <Book>[].obs;
  var _userListRepository = UserListsRepository();

  var startedAt = Rxn<DateTime>();
  var finishedAt = Rxn<DateTime>();

  void setStartedAt(DateTime date) {
    startedAt.value = date;
  }

  void setFinishedAt(DateTime date) {
    finishedAt.value = date;
  }

  @override
  void onInit() {
    super.onInit();
    fetchReadHistory();
  }

  void fetchReadHistory() async {
    try {
      isLoading.value = true;
      var history = await UserListsRepository.fetchHistory();
      if (history != null) {
        print("not null history");
        historyList.value = history;
        isLoading.value = false;
      }
      isLoading.value = false;
    } catch (e) {
      print('error catched history list ' + e.toString());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToHistory(String bookId, String StartedAt, String totReadTime,
      String finishedAt) async {
    try {
      final response = await _userListRepository.addToHistory(
          StartedAt, totReadTime, finishedAt, bookId);
      if (response.statusCode == 200) {
        print('history adding  200');
        fetchReadHistory();
        Get.back();
        Loaders.successSnackBar(
            title: 'Success', message: response.body.toString());
      } else {
        Get.snackbar('Error', 'Failed to add to histoy');
      }
    } catch (e) {
      print(e.toString());
      Get.snackbar('Error', e.toString());
    }
  }
}
