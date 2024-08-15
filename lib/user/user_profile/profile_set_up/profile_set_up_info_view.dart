import 'dart:io';

import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/user/user_profile/profile_set_up/profile_set_up_info_controller.dart';
import 'package:booktaste/user/user_profile/profile_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUpdatePage extends StatelessWidget {
  ProfileUpdatePage({Key? key, this.profile}) : super(key: key) {
    if (profile != null) {
      controller.nameController.text = profile!.name ?? '';
      controller.imageUrl.value =
          profile!.profilePhoto?.toString() ?? Images.user;
      controller.selecedGenres.addAll(
          profile!.favGenres?.map((genre) => genre.genre.toString()) ?? []);
      // controller.profileUpdate.value = true;
    }
  }

  final Profile? profile;
  final controller = Get.put(SetUpProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //!Profile Picture
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Obx(
                          () => Container(
                            height: 90,
                            width: 90,
                            margin: EdgeInsets.all(Sizes.xs),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Theme.of(context)
                                  .colorScheme
                                  .background
                                  .withOpacity(0.2),
                            ),
                            child: Center(
                              child: controller.isImageUploading.value
                                  ? CircularProgressIndicator(color: lightBrown)
                                  : controller.imageUrl.value
                                          .startsWith('/profiles')
                                      ? SizedBox(
                                          width: 100,
                                          height: 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: MyNetworkImage(
                                              imageUrl: profile!.profilePhoto
                                                  .toString(), //book!.cover,
                                              shHeight: 30,
                                              shWidth: 40,
                                              notFoundImage:
                                                  Images.coffeeLoading,
                                            ),
                                          ),
                                        )
                                      : controller.imageUrl.value ==
                                                  Images.user ||
                                              controller.imageUrl.value == '/'
                                          ? SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.asset(Images.user,
                                                    fit: BoxFit.cover),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image.file(
                                                    File(controller
                                                        .imageUrl.value),
                                                    fit: BoxFit.cover),
                                              ),
                                            ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.pickImage();
                          },
                          child: Text('Choose Picture'),
                        )
                      ],
                    ),
                  ),

                  TextField(
                    controller: controller.nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  SizedBox(
                    height: Sizes.md,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('What book genres do you like? '),
                      SizedBox(height: Sizes.spaceBtwInputFields / 2),
                      Obx(
                        () => Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8.0,
                          runSpacing: 4.0,
                          children: controller.genres.map((genre) {
                            final isSelected =
                                controller.selecedGenres.contains(genre);
                            return ChoiceChip(
                              side: BorderSide.none,
                              selectedColor: lightBrown.withOpacity(0.8),
                              backgroundColor: lightBrown.withOpacity(0.3),
                              label: Text(genre),
                              selected: isSelected,
                              onSelected: (_) {
                                controller.toggleGenreSelection(genre);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),

                  // SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     List<String> genres = genresController.text.split(',');
                  //     controller.updateProfile(
                  //       nameController.text,
                  //       imageController.text,
                  //       genres.map((genre) => genre.trim()).toList(),
                  //     );
                  //   },
                  //   child: Text('Update Profile'),
                  // ),
                  //! Save Button
                  const SizedBox(height: Sizes.defaultSpace),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.selecedGenres.isEmpty) {
                          Loaders.warningSnackBar(
                            title: 'Oops',
                            message:
                                'Please pick at least one favourite genre...',
                          );
                        } else {
                          controller.updateProfile();
                        }
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
