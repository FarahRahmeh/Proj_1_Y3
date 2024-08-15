import 'package:booktaste/auth/login/login_page.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/images/circular_image.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/user/user_profile/user_profile_widgets/profile_menu.dart';
import 'package:booktaste/user/user_profile/user_profile_widgets/user_delete_profile.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final deletecontroller = Get.put(DeleteaccountRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              //!Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CircularImage(
                      image: Images.onboarding_1,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text('Change Picture'),
                    )
                  ],
                ),
              ),
              //!Details
              const SizedBox(
                height: Sizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              SectionHeading(
                title: 'Profile Inforamtion',
                showActionButton: false,
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),

              ProfileMenu(
                  title: 'Name :', value: 'UserName Here', onPressed: () {}),

              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              SectionHeading(
                title: 'Personal Inforamtion',
                showActionButton: false,
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              ProfileMenu(
                  title: 'Email :', value: 'E-mail Here', onPressed: () {}),
              ProfileMenu(
                title: 'UserId :',
                value: '22212',
                onPressed: () {},
                icon: Iconsax.copy_copy,
              ),

              //todo more examples for ProfileMenu:   userId, Gender, phone ,date of birth ....

              const Divider(),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    MyDialogs.defaultDialog(
                        context: context,
                        title: 'Delete Account',
                        content: Text(
                            'Are you sure you wont to delete your account?'),
                        onConfirm: () {
                          deletecontroller.deleteAccount();
                          Get.offAll(LoginPage());
                        },
                        onCancel: () => Get.back(),
                        confirmText: 'Delete');
                  },
                  child: Text(
                    'Delete Account',
                    style: TextStyle(color: pinkish),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
