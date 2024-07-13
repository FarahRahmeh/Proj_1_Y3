import 'package:get/get.dart';

class AdminHomeController extends GetxController {
  final carousalCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }
}
