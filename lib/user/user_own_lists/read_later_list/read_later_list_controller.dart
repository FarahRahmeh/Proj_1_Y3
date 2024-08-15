import 'package:booktaste/data/repositories/user_lists_repository.dart';
import 'package:booktaste/user/user_own_lists/read_later_list/read_later_model.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:get/get.dart';

class ReadLaterListController extends GetxController {
  var isLoading = true.obs;
  var readLaterList = <ReadLater>[].obs;
  var _userListRepository = UserListsRepository();
  var currentOrder = 'asc'.obs;

  var priority = 'low'.obs;

  void setPriority(String value) {
    priority.value = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchReadingList(currentOrder.value);
  }

  void fetchReadingList(String order) async {
    try {
      isLoading.value = true;
      var readLater = await UserListsRepository.fetchReadLater(order);
      if (readLater != null) {
        print("not null read later list ");
        readLaterList.value = readLater;
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

  Future<void> addToLater(String bookId, String priority) async {
    try {
      final response =
          await _userListRepository.addToReadLater(priority, bookId);
      if (response.statusCode == 200) {
        fetchReadingList(currentOrder.value);
        Get.back();
        print('read later adding  200');
        Loaders.successSnackBar(
            title: 'Success', message: response.body.toString());
      } else {
        Get.snackbar('Error', 'Failed to add to read later');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
