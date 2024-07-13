import 'package:booktaste/admin/manage_admins/add_new_admin_page.dart';
import 'package:booktaste/admin/manage_books/manage_book_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/list_tile/setting_menu_tile.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/user/user_profile/user_profile.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/popups/custom_dialog.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../common/widgets/custom_shapes/Containers/primary_header_container.dart';
import '../../common/widgets/list_tile/user_profile_tile.dart';
import '../../controllers/theme/theme_controller.dart';
import '../../utils/constans/sizes.dart';
import '../manage_books/add_new_book_page.dart';

class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({super.key});

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
                  ///! Account Settings----------------------------------------------
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

//!
                  SettingsMenuTile(
                      icon: Iconsax.book_saved_copy,
                      title: 'Add New Book',
                      subTitle: 'Adding new book to booktaste',
                      onTap: () {
                        Get.to(() => const AddNewBookPage());
                      }),

//!
                  SettingsMenuTile(
                      icon: Iconsax.security_user_copy,
                      title: 'Add New Admin',
                      subTitle: 'Only Master Admin can add new admins',
                      //! Handling ...!!!!!!!!!!!
                      onTap: () {
                        if (GetStorage().read('ROLE') != 'master_admin') {
                          MyDialogs.defaultDialog(
                            showOnlyOnConfirm: true,
                            confirmText: 'Ok',
                            context: context,
                            title: 'Sorry !',
                            content:
                                Text('Only Master Admin can add new admins'),
                            onConfirm: () {
                              Get.back();
                            },
                          );
                        } else {
                          Get.to(() => const AddNewAdminPage());
                          Loaders.successSnackBar(
                              duration: 3,
                              icon: Iconsax.status_up_copy,
                              title: "Hello Boss! 😎",
                              message:
                                  'Boost productivity with a new admin on board!');
                        }
                      }),

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

                  ///! App Settings-----------------------------------------------------
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
                    trailing: Switch(
                      value: true,
                      onChanged: (value) {},
                      inactiveThumbColor: gray,
                    ),
                  ), //

                  SettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: 'Safe Mode',
                    subTitle: 'Search result is safe for all ages',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                      inactiveThumbColor: gray,
                    ),
                  ), //

                  SettingsMenuTile(
                    icon: Iconsax.image,
                    title: 'HD Image Quality',
                    subTitle: 'Set image quality to be seen',
                    trailing: Switch(
                      value: false,
                      onChanged: (value) {},
                      inactiveThumbColor: gray,
                    ),
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

// class MySwitch extends StatelessWidget {
//   const MySwitch({
//     super.key,
//   });

//   final bool value;
//   final 
//   @override
//   Widget build(BuildContext context) {
//     return Switch(
//       value: true,
//       onChanged: (value) {},
//       //! swicht theme

//       // thumbIcon: MaterialStateProperty.resolveWith(
//       //     (states) => Icon(Iconsax.aave_aave)),
//       activeColor: offWhite, //the circle
//       activeTrackColor: lightBrown,
//       focusColor: lightBrown,
//       inactiveTrackColor: brown,
//       inactiveThumbColor: gray,
//       // thumbColor: MaterialStateColor.resolveWith((states) => brown),
//       //overlayColor: MaterialStateColor.resolveWith(
//       //    (states) => lightBrown),
//       //hoverColor: lightBrown,
    // );
//   }
// }
