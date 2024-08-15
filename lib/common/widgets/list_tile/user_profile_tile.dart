import 'dart:convert';

import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/user/user_profile/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/colors.dart';
import '../../../utils/constans/images.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    this.onPressed,
  });
  final VoidCallback? onPressed;
  @override
  Widget build(BuildContext context) {
    final profileCtrl = Get.put(ProfileController());
    profileCtrl.getProfileInfo();
    print(profileCtrl.profile.value.name);
    return FutureBuilder<bool>(
        future: isUser(),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data;
            return ListTile(
                leading: Obx(
                  () => profileCtrl.profile.value.profilePhoto
                              .toString()
                              .startsWith('/profiles') &&
                          user == true
                      ? SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: MyNetworkImage(
                              imageUrl: profileCtrl.profile.value.profilePhoto
                                  .toString(),
                              shHeight: 30,
                              shWidth: 40,
                              notFoundImage: Images.user,
                            ),
                          ),
                        )
                      : SizedBox(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(Images.user, fit: BoxFit.cover),
                          ),
                        ),
                ),
                title: Obx(() => Text(
                      profileCtrl.profile.value.name.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: MyColors.white),
                    )),
                subtitle: Obx(() => Text(
                      profileCtrl.profile.value.email.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: MyColors.white),
                    )),
                trailing: user == true
                    ? IconButton(
                        onPressed: onPressed,
                        icon: Icon(Iconsax.edit_2, color: MyColors.white))
                    : SizedBox.shrink());
          }
        });
  }
}
