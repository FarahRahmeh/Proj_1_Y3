import 'package:booktaste/auth/change_password/change_password_page.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/user/user_profile/profile_set_up/profile_set_up_info_view.dart';
import 'package:booktaste/user/user_profile/user_profile_controller.dart';
import 'package:booktaste/user/user_profile/user_profile_widgets/profile_menu.dart';
import 'package:booktaste/user/user_profile/user_profile_widgets/user_level_card.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    // final authCtrl = Get.find<LoginController>();
    final profileCtrl = Get.put(ProfileController());
    profileCtrl.getProfileInfo();
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => ProfileUpdatePage(
                    profile: profileCtrl.profile.value,
                  ));
            },
            icon: Icon(Iconsax.brush_1_copy),
          ),
        ],
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
                    Obx(() => profileCtrl.profile.value.profilePhoto
                            .toString()
                            .startsWith('/profiles')
                        ? SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: MyNetworkImage(
                                imageUrl: profileCtrl.profile.value.profilePhoto
                                    .toString(),
                                shHeight: 30,
                                shWidth: 40,
                                notFoundImage: Images.coffeeLoading,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child:
                                  Image.asset(Images.user, fit: BoxFit.cover),
                            ),
                          )),
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

              Obx(
                () => ProfileMenu(
                    title: 'Name :',
                    value: profileCtrl.profile.value.name.toString(),
                    onPressed: () {}),
              ),

              Obx(
                () => ProfileMenu(
                    title: 'Email :',
                    value: profileCtrl.profile.value.email.toString(),
                    onPressed: () {}),
              ),
              Obx(
                () => ProfileMenu(
                  title: 'Bookbux :',
                  value: profileCtrl.profile.value.myPoints.toString(),
                  onPressed: () {},
                  icon: Iconsax.copy_copy,
                ),
              ),
              const Divider(),

              ProfileMenu(
                title: 'Favourite Genres:',
                // value: auth.authModel.value.user!.role().toString(),
                onPressed: () {},
                icon: Iconsax.copy_copy,
              ),
              Row(
                children: [
                  Expanded(
                    child: Wrap(
                      children: profileCtrl
                                  .profile.value.favGenres?.isNotEmpty ==
                              true
                          ? profileCtrl.profile.value.favGenres!
                              .map((favGenre) {
                              return GestureDetector(
                                child: RoundedContainer(
                                  borderColor: MyColors.grey,
                                  showBorder: true,
                                  margin: EdgeInsets.all(Sizes.xs),
                                  radius: Sizes.sm,
                                  backgroundColor: lightBrown.withOpacity(0.6),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: Sizes.sm, vertical: Sizes.xs),
                                  child: Text(
                                    favGenre.genre ?? 'Unknown Genre',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .apply(
                                            color: dark
                                                ? offWhite
                                                : MyColors.black),
                                  ),
                                ),
                              );
                            }).toList()
                          : [Text('No favorite genres added')],
                    ),
                  ),
                ],
              ),

              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              const Divider(),
              ProfileMenu(
                showIcon: true,
                title: 'Change password :',
                value: '',
                onPressed: () {
                  Get.to(() => const ChangePasswordPage());
                },
                icon: Iconsax.unlock_copy,
              ),

              // const SizedBox(height: Sizes.spaceBtwItems),
              const Divider(),

              //! Level Section
              const SectionHeading(
                title: 'Level',
                showActionButton: false,
              ),
              const SizedBox(height: Sizes.spaceBtwItems),
              Obx(() => profileCtrl.profile.value.achievementName != null
                  ? LevelCard()
                  : const Text(
                      'you need to read at least 5 books.',
                      style: TextStyle(color: MyColors.grey),
                    )),

              const Divider(),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
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

class LevelCard extends StatelessWidget {
  const LevelCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final profileCtrl = Get.put(ProfileController());
    profileCtrl.getProfileInfo();
    return GestureDetector(
      onTap: () {
        MyDialogs.defaultDialog(
            context: context,
            title: 'Your Level ',
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    profileCtrl.profile.value.achievementName! + ' !',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: pinkishMore),
                  ),
                  Image(
                    image: AssetImage(
                        'assets/images/Level${profileCtrl.profile.value.achievementId}.png'),
                    width: 130,
                    height: 130,
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems / 2),
                  Text(
                    profileCtrl.profile.value.achievementMessage!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            showOnlyOnConfirm: true,
            onConfirm: () {
              Get.back();
            },
            confirmText: 'Let`s Go!');
      },
      child: RoundedContainer(
        backgroundColor: lightBrown.withOpacity(0.7),
        padding: EdgeInsets.all(Sizes.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(
                      image: AssetImage(
                          'assets/images/Level${profileCtrl.profile.value.achievementId}.png'),
                      width: 60,
                      height: 60,
                    ),
                    Text(
                      profileCtrl.profile.value.achievementName! + ' !',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
