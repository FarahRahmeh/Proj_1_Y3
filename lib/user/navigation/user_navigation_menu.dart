import 'package:booktaste/common/widgets/navigation_dest/my_navigation_destination.dart';
import 'package:booktaste/user/user_home/user_home_page.dart';
import 'package:booktaste/user/user_library/user_library_page.dart';
import 'package:booktaste/user/user_setting/user_setting_page.dart';
import 'package:booktaste/user/user_wishlist/favourite_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserNavigationMenu extends StatelessWidget {
  const UserNavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
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
                icon: Iconsax.home_1,
                label: 'Home',
                selectedIcon: Iconsax.home_copy),
            MyNavigationDestination(
              label: 'Library',
              icon: Iconsax.book_square,
              selectedIcon: Iconsax.book_square_copy,
            ),
            MyNavigationDestination(
                icon: Iconsax.heart,
                label: 'Wishlist',
                selectedIcon: Iconsax.heart_copy),
            MyNavigationDestination(
                icon: Iconsax.user,
                label: 'Profile',
                selectedIcon: Iconsax.user_copy),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    UserHomePage(),
    const UserLibrary(),
    const FavouritePage(),
    // const UserProfile(),
    const UserSettingsPage(),
  ];
}
//comment to test