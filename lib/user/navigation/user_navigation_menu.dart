import 'package:booktaste/common/widgets/navigation_dest/my_navigation_destination.dart';
import 'package:booktaste/user/user_home/user_home_page.dart';
import 'package:booktaste/user/user_library/user_library_page.dart';
import 'package:booktaste/user/user_own_lists/user_all_lists_view.dart';
import 'package:booktaste/user/user_quotes/quotes_and_qbooks.dart';
import 'package:booktaste/user/user_setting/user_setting_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserNavigationMenu extends StatelessWidget {
  const UserNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserNavigationController());
    final darkMode = HelperFunctions.isDarkMode(context);

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          indicatorColor: darkMode
              ? lightBrown.withOpacity(0.3)
              : darkBrown.withOpacity(0.2),
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: darkMode ? MyColors.black : Colors.white,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: [
            MyNavigationDestination(
                icon: Iconsax.home_copy,
                label: 'Home',
                selectedIcon: Iconsax.home_1),
            MyNavigationDestination(
              label: 'Library',
              icon: Iconsax.book_square_copy,
              selectedIcon: Iconsax.book_square,
            ),
            MyNavigationDestination(
                icon: Iconsax.heart_copy,
                label: 'My Nook',
                selectedIcon: Iconsax.heart),
            MyNavigationDestination(
                icon: Iconsax.quote_down_copy,
                label: 'Quotes',
                selectedIcon: Iconsax.quote_down),
            MyNavigationDestination(
                icon: Iconsax.user_copy,
                label: 'Profile',
                selectedIcon: Iconsax.user),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class UserNavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    UserHomePage(),
    const UserLibrary(),
    UserAllListsView(),
    QuotesAndNotesPage(),
    const UserSettingsPage(),
  ];
  void setSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}
  //!Example =====>>
  //!   final navigationController = Get.find<NavigationController>();
  //!    navigationController.setSelectedIndex(3);