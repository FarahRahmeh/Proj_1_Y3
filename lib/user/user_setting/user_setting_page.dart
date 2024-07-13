import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/list_tile/setting_menu_tile.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/theme/theme_controller.dart';
import 'package:booktaste/user/user_address/address_page.dart';
import 'package:booktaste/user/user_profile/user_profile.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../common/widgets/custom_shapes/Containers/primary_header_container.dart';
import '../../common/widgets/list_tile/user_profile_tile.dart';
import '../../utils/constans/sizes.dart';
import '../../utils/popups/dialogs.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Header
            PrimaryHeaderContainer(
              height: 225,
              child: Column(
                children: [
                  /// AppBar
                  MyAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .apply(color: MyColors.white),
                    ),
                  ),

                  /// User Profile Card
                  UserProfileTile(
                      onPressed: () => Get.to(() => const UserProfile())),
                  SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
            // Body

            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  ///! Account Settings
                  const SectionHeading(
                      title: 'Account Setting', showActionButton: false),
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),

                  //Tiles
                  SettingsMenuTile(
                    icon: Iconsax.profile_circle_copy,
                    title: 'Title',
                    subTitle: 'Add, remove,edit products ....',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.safe_home_copy,
                    title: 'Addresses',
                    subTitle: 'blah blahhh blahhhhh',
                    onTap: () => Get.to(() => const AddBookPage()),
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.notification_copy,
                    title: 'Title',
                    subTitle: 'blah blahhh blahhhhh',
                    onTap: () {},
                  ),

                  SettingsMenuTile(
                    icon: Iconsax.star_1_copy,
                    title: 'Title',
                    subTitle: 'blah blahhh blahhhhh',
                    onTap: () {},
                  ),
                  SettingsMenuTile(
                    icon: Iconsax.chart_1_copy,
                    title: 'Title',
                    subTitle: 'blah blahhh blahhhhh',
                    onTap: () {},
                  ),

                  ///! App Settings
                  SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  SectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),

                  //! Theme Tile
                  SettingsMenuTile(
                      icon: Iconsax.brush,
                      // Iconsax.brush_3_copy,
                      title: 'Theme Mode',
                      subTitle: 'Change to dark , light or system theme mode',
                      onTap: () {
                        return MyDialogs.defaultDialog(
                          showOnlyOnConfirm: true,
                          confirmText: 'Close',
                          context: context,
                          title: 'Theme Mode :',
                          content: SizedBox(
                            height: 170,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Obx(() => RadioListTile(
                                      title: Text('system'),
                                      value: ThemeMode.system,
                                      groupValue:
                                          themeController.themeMode.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          themeController
                                              .changeThemeMode(value);
                                        }
                                      },
                                    )),
                                Obx(() => RadioListTile(
                                      title: Text('dark'),
                                      value: ThemeMode.dark,
                                      groupValue:
                                          themeController.themeMode.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          themeController
                                              .changeThemeMode(value);
                                        }
                                      },
                                    )),
                                Obx(() => RadioListTile(
                                      title: Text('light'),
                                      value: ThemeMode.light,
                                      groupValue:
                                          themeController.themeMode.value,
                                      onChanged: (value) {
                                        if (value != null) {
                                          themeController
                                              .changeThemeMode(value);
                                        }
                                      },
                                    )),
                              ],
                            ),
                          ),
                          onConfirm: () {
                            Get.back();
                          },
                        );
                      }),
                  SettingsMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subTitle: 'Set recommendation based on Location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ), //

                  SettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ), //

                  SettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(value: false, onChanged: (value) {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
