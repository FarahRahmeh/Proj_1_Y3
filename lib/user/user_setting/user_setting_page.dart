import 'package:booktaste/auth/login/login_page.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/list_tile/setting_menu_tile.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/theme/theme_controller.dart';
import 'package:booktaste/data/repositories/auth_repository.dart';
import 'package:booktaste/user/user_book_request/user_book_request_view.dart';
import 'package:booktaste/user/user_contact_us/user_send_contact_message_view.dart';
import 'package:booktaste/user/user_inquiries/user_inquiries_view.dart';
import 'package:booktaste/user/user_profile/profile_set_up/profile_set_up_info_view.dart';
import 'package:booktaste/user/user_profile/user_profile_page.dart';
import 'package:booktaste/user/user_statistics/user_insights_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../admin/manage_books/add_book/add_new_book_page.dart';
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
                      onPressed: () => Get.to(() => const UserProfilePage())),
                  SizedBox(height: Sizes.spaceBtwSections),
                ],
              ),
            ),
            // Body

            Column(
              children: [
                ///! Account Settings
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
                  icon: Iconsax.profile_circle_copy,
                  title: 'Title',
                  subTitle: 'Add, remove,edit products ....',
                  onTap: () {
                    Get.to(() => ProfileUpdatePage());
                  },
                ),
                //! New book request
                SettingsMenuTile(
                    icon: Iconsax.book_saved_copy,
                    title: 'Request Book',
                    subTitle: 'Request a book to add it to BookTaste Library.',
                    onTap: () {
                      Get.to(() => AddNewBookPage());
                    }),

                // SettingsMenuTile(
                //   icon: Iconsax.notification_copy,
                //   title: 'Title',
                //   subTitle: 'blah blahhh blahhhhh',
                //   onTap: () {},
                // ),
                // //! Book Requests Page
                SettingsMenuTile(
                  icon: Iconsax.task_copy,
                  title: 'Book Requests',
                  subTitle: ' book requests.',
                  onTap: () {
                    Get.to(() => UserBookRequestsPage());
                  },
                ),
                //! contact us
                SettingsMenuTile(
                  icon: Iconsax.messages_1_copy,
                  title: 'Contact Us',
                  subTitle: 'Send your notes to admins ...',
                  onTap: () {
                    Get.to(() => SendContactView());
                  },
                ),
                SettingsMenuTile(
                  icon: Iconsax.message_question_copy,
                  title: 'Inquiries',
                  subTitle: 'all  your inquiries on book in one place ...',
                  onTap: () {
                    Get.to(() => UserInquiriesPage());
                  },
                ),
                //! Statistics
                SettingsMenuTile(
                  icon: Iconsax.chart_1_copy,
                  title: 'Statistics',
                  subTitle: 'your activity insights here',
                  onTap: () {
                    Get.to(() => UserInsightsPage());
                  },
                ),

                ///! App Settings
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
                //   trailing: Switch(value: true, onChanged: (value) {}),
                // ), //

                // SettingsMenuTile(
                //   icon: Iconsax.security_user,
                //   title: 'Safe Mode',
                //   subTitle: 'Search result is safe for all ages',
                //   trailing: Switch(value: false, onChanged: (value) {}),
                // ), //

                // SettingsMenuTile(
                //   icon: Iconsax.image,
                //   title: 'HD Image Quality',
                //   subTitle: 'Set image quality to be seen',
                //   trailing: Switch(value: false, onChanged: (value) {}),
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
