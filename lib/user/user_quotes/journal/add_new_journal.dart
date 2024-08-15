import 'package:booktaste/user/user_quotes/journal/journal_controller.dart';
import 'package:booktaste/user/user_quotes/journal/journal_model.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../common/features/const_Images/const_image_view.dart';
import '../../../common/features/const_Images/const_images_controller.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/popups/dialogs.dart';
import '../../../utils/popups/loaders.dart';
import 'package:path/path.dart' as p;

class NewJournal extends StatelessWidget {
  NewJournal({Key? key, this.journal}) : super(key: key) {
    if (journal != null) {
      journalCtrl.journal.value = journal!;
    }
  }
  final Journal? journal;
  final journalCtrl = Get.put(JournalController());
  final journalCoverCtrl = Get.put(ConstImagesController());

  @override
  Widget build(BuildContext context) {
    final TextEditingController nameController =
        TextEditingController(text: journal?.name ?? '');
    final TextEditingController bioController =
        TextEditingController(text: journal?.bio ?? '');
    if (journal != null) {
      journalCoverCtrl.selectedImage.value = journal?.imageName ?? '';
      journalCoverCtrl.selectedImage.value =
          journalCoverCtrl.imagePathMap[journal?.imageName] ?? '';
    }
    return IconButton(
      onPressed: () {
        MyDialogs.defaultDialog(
          context: context,
          title: journal == null ? 'New Journal Details:' : 'Edit Journal',
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Sizes.spaceBtwInputFields / 2,
                ),
                TextField(
                  controller: nameController,
                  onChanged: (value) => journalCtrl.journal.value.name = value,
                  decoration: InputDecoration(
                    labelText: 'Journal Name',
                  ),
                ),
                SizedBox(
                  height: Sizes.spaceBtwInputFields / 2,
                ),
                TextField(
                  controller: bioController,
                  onChanged: (value) => journalCtrl.journal.value.bio = value,
                  decoration: InputDecoration(
                    labelText: 'Bio (optional)',
                  ),
                ),
                SizedBox(
                  height: Sizes.spaceBtwInputFields / 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Sizes.sm),
                      child: Text(
                        'Select Jouranl Cover: ',
                        style: TextStyle(
                            color: brown, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  children: journalCoverCtrl.journalCovers.map((cover) {
                    return ConstImageView(
                      image: cover,
                      isSelected: journalCoverCtrl.isSelected(cover),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          cancelText: 'Cancel',
          confirmText: journal == null ? 'Add' : 'Update',
          onCancel: () => Get.back(),
          onConfirm: () {
            if (nameController.text.isEmpty) {
              Loaders.warningSnackBar(
                title: 'Name',
                message: 'Journal name cannot be empty',
              );
              return;
            }
            if (journalCoverCtrl.selectedImage.value.isEmpty) {
              Loaders.warningSnackBar(
                title: 'Image Cover',
                message: 'Please select a journal cover',
              );
              return;
            }

            if (journalCoverCtrl.selectedImage.value.isNotEmpty) {
              String imageName = p.basenameWithoutExtension(
                  journalCoverCtrl.selectedImage.value);
              print(imageName);

              journalCtrl.journal.value.bio =
                  bioController.text.isNotEmpty ? bioController.text : null;
              journalCtrl.journal.value.name = nameController.text;
              journalCtrl.journal.value.year = DateTime.now().year.toString();
              journalCtrl.journal.value.imageName = imageName;
              if (journal == null) {
                journalCtrl.saveJournal();
              } else {
                journalCtrl.journalUpdate();
              }
            }
            journalCoverCtrl.selectedImage.value = '';
            nameController.clear();
            bioController.clear();

            Get.back();
          },
        );
      },
      icon: Icon(
          journal == null ? Iconsax.element_plus_copy : Iconsax.edit_2_copy),
    );
  }
}
