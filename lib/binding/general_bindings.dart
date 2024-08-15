import 'package:booktaste/auth/login/login_controller.dart';
import 'package:booktaste/controllers/theme/theme_controller.dart';
import 'package:booktaste/data/services/network_manager.dart';
import 'package:booktaste/user/user_profile/profile_model.dart';
import 'package:booktaste/user/user_profile/user_profile_controller.dart';
import 'package:get/get.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    //Get.put(AllCategoriesController(), permanent: true); //, permanent: true
    // Get.put(CafesController());
    // Get.put(AllBooksController());
    // Get.put(CafeShelvesController());
    // Get.put(BookDetailsController());
    Get.put(LoginController());
    Get.put(ProfileController());
    Get.put(ThemeController());
  }
}
