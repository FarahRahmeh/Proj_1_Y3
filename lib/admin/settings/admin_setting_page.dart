import 'package:booktaste/admin/admin_book_request/admin_book_request_view.dart';
import 'package:booktaste/admin/manage_admins/add_new_admin_page.dart';
import 'package:booktaste/auth/login/login_page.dart';
import 'package:booktaste/common/features/challenges/challenges_view.dart';
import 'package:booktaste/common/features/contact_us/all_contact_us_view.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/list_tile/setting_menu_tile.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/data/repositories/auth_repository.dart';
import 'package:booktaste/user/user_profile/user_profile_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
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
import '../manage_books/add_book/add_new_book_page.dart';

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
                      onPressed: () => Get.to(() => const UserProfilePage())),
                  SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
            // Body
            Column(
              children: [
                ///! Account Settings----------------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.defaultSpace),
                  child: const SectionHeading(
                      title: 'Account Setting', showActionButton: false),
                ),
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),

                //Tiles
                SettingsMenuTile(
                  icon: Iconsax.cup_copy,
                  title: 'Challenges',
                  subTitle: 'good  ....',
                  onTap: () {
                    Get.to(() => ChallengesView());
                  },
                ),

//!
                SettingsMenuTile(
                    icon: Iconsax.book_saved_copy,
                    title: 'Add New Book',
                    subTitle: 'Add new book to BookTaste Library.',
                    onTap: () {
                      Get.to(() => AddNewBookPage());
                    }),

//!
                SettingsMenuTile(
                    icon: Iconsax.profile_add_copy,
                    title: 'Add New Admin',
                    subTitle: 'Only Master Admin can add manage admins',
                    //! Handling ...!!!!!!!!!!!
                    onTap: () {
                      if (GetStorage().read('ROLE') != 'master_admin') {
                        MyDialogs.defaultDialog(
                          showOnlyOnConfirm: true,
                          confirmText: 'Ok',
                          context: context,
                          title: 'Sorry !',
                          content:
                              Text('Only Master Admin can add new admins.'),
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
                //!  Book Requests
                SettingsMenuTile(
                  icon: Iconsax.task_copy,
                  title: 'Book Requests',
                  subTitle: 'Accept, reject, edit users book requests.',
                  onTap: () {
                    Get.to(() => AdminBookRequestsView());
                  },
                ),

                //! Unedited
                SettingsMenuTile(
                  icon: Iconsax.messages_1_copy,
                  title: 'Contact Us',
                  subTitle: 'reply and show messages from users',
                  onTap: () {
                    Get.to(() => AllContactUsPage());
                  },
                ),

                ///! App Settings-----------------------------------------------------
                SizedBox(
                  height: Sizes.spaceBtwSections,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.defaultSpace),
                  child: SectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
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
                                    groupValue: themeController.themeMode.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        themeController.changeThemeMode(value);
                                      }
                                    },
                                  )),
                              Obx(() => RadioListTile(
                                    title: Text('dark'),
                                    value: ThemeMode.dark,
                                    groupValue: themeController.themeMode.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        themeController.changeThemeMode(value);
                                      }
                                    },
                                  )),
                              Obx(() => RadioListTile(
                                    title: Text('light'),
                                    value: ThemeMode.light,
                                    groupValue: themeController.themeMode.value,
                                    onChanged: (value) {
                                      if (value != null) {
                                        themeController.changeThemeMode(value);
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

                // SettingsMenuTile(
                //   icon: Iconsax.location,
                //   title: 'Geolocation',
                //   subTitle: 'Set recommendation based on Location',
                //   trailing: Switch(
                //     value: true,
                //     onChanged: (value) {},
                //     inactiveThumbColor: gray,
                //   ),
                // ), //

                // SettingsMenuTile(
                //   icon: Iconsax.security_user,
                //   title: 'Safe Mode',
                //   subTitle: 'Search result is safe for all ages',
                //   trailing: Switch(
                //     value: false,
                //     onChanged: (value) {},
                //     inactiveThumbColor: gray,
                //   ),
                // ), //

                // SettingsMenuTile(
                //   icon: Iconsax.image,
                //   title: 'HD Image Quality',
                //   subTitle: 'Set image quality to be seen',
                //   trailing: Switch(
                //     value: false,
                //     onChanged: (value) {},
                //     inactiveThumbColor: gray,
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final response = await AuthRepository().logout();
                      if (response.statusCode == 200) {
                        Loaders.successSnackBar(
                            title: 'Logout success',
                            message: 'see you later..🤍 ');
                        GetStorage().remove('TOKEN');
                        Get.offAll(() => LoginPage());
                      } else {
                        print(response.body.toString());
                        Loaders.errorSnackBar(title: 'Logout failed');
                      }
                    } catch (e) {
                      print(e.toString());
                      Loaders.errorSnackBar(
                          title: 'Logout failed with exception');
                    }
                  },
                  child: Text('Logout'),
                ),
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
