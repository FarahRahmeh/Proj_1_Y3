import 'package:booktaste/admin/navigation/admin_navigation_menu.dart';
import 'package:booktaste/user/navigation/user_navigation_menu.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<String?> getRole() async {
  final box = GetStorage();
  return box.read('ROLE');
}

Future<void> saveRole(String role) async {
  final box = GetStorage();
  await box.write('ROLE', role);
}

Future<bool> isUser() async {
  final role = await getRole(); // Retrieve the role
  print("user is " + role.toString());
  return role == 'user';
}

void navigateBasedOnRole() async {
  final role = await getRole(); // Retrieve the role
  if (role == 'master_admin' || role == 'admin') {
    Get.offAll(() => const AdminNavigationMenu());

    //todo Change the route name
  } else if (role == 'user') {
    Get.offAll(() => const UserNavigationMenu());

    //todo Change the route name
  }
}
