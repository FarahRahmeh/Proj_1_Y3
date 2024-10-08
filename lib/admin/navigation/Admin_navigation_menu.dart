import 'package:booktaste/admin/home/admin_home_page.dart';
import 'package:booktaste/admin/library/admin_library_page.dart';
import 'package:booktaste/admin/settings/admin_setting_page.dart';
import 'package:booktaste/common/widgets/navigation_dest/my_navigation_destination.dart';
import 'package:booktaste/user/user_library/user_library_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../insights/admin_insignts_page.dart';

class AdminNavigationMenu extends StatelessWidget {
  const AdminNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AdminNavigationController());
    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          indicatorColor:
              dark ? lightBrown.withOpacity(0.3) : darkBrown.withOpacity(0.2),
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: [
            ///! Make it custom -----------------------------------
            MyNavigationDestination(
                label: 'Home',
                icon: Iconsax.home_copy,
                selectedIcon: Iconsax.home_1),
            MyNavigationDestination(
              label: 'Library',
              icon: Iconsax.book_square_copy,
              selectedIcon: Iconsax.book_square,
            ),
            MyNavigationDestination(
              label: 'Insignts',
              icon: Iconsax.layer_copy,
              selectedIcon: Iconsax.layer,
            ),
            MyNavigationDestination(
                icon: Iconsax.setting_2_copy,
                label: 'Settings',
                selectedIcon: Iconsax.setting_2)
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class AdminNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    AdminHomePage(),
    UserLibrary(),
    InsightsPage(),
    const AdminSettingsPage(),
  ];
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }

  //!Example =====>>
  //!   final navigationController = Get.find<NavigationController>();
  //!    navigationController.setSelectedIndex(3);
}
