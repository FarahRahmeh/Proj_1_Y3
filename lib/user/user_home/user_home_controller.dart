import 'package:get/get.dart';

class UserHomeController extends GetxController {
  final carousalCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
}
