import 'dart:convert';

import 'package:booktaste/common/features/const_Images/const_images_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/user/user_quotes/journal/journal_card.dart';
import 'package:booktaste/user/user_quotes/journal/journal_controller.dart';
import 'package:booktaste/user/user_quotes/journal/journal_model.dart';
import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:booktaste/user/user_quotes/quotes_controller.dart';
import 'package:booktaste/user/user_quotes/quotes_page.dart';
import 'package:booktaste/user/user_quotes/quotes_widgets/add_new_quote_page.dart';
import 'package:booktaste/user/user_quotes/quotes_widgets/quote_card.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:path/path.dart' as p;

import '../../common/features/const_Images/const_image_view.dart';

class QuotesAndNotesPage extends StatelessWidget {
  QuotesAndNotesPage({super.key});
  final journalCtrl = Get.put(JournalController());
  @override
  Widget build(BuildContext context) {
    final journalCoverCtrl = Get.put(ConstImagesController());
    final ctrl = Get.put(AllQuotesController());

    final TextEditingController nameController = TextEditingController();
    final TextEditingController bioController = TextEditingController();

    void showDeleteDialog(String journalId) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete Journal'),
            content: Text(
                'Do you want to delete the journal only or the journal with its quotes?'),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          journalCtrl.JournalDelete(journalId, true);
                          Get.back();
                        },
                        child: Text('Journal Only'),
                      ),
                      TextButton(
                        onPressed: () {
                          journalCtrl.JournalDelete(journalId, false);
                          Get.back();
                        },
                        child: Text('Journal and its Quotes'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancel'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      );
    }

    final dark = HelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: false,
        title: Text('Quotes and QuoteBooks'),
        actions: [
          //! New Journal Btn
          IconButton(
            onPressed: () {
              MyDialogs.defaultDialog(
                // backgroundColor: gray,
                context: context,
                title: 'New Journal Details: ',
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: Sizes.spaceBtwInputFields / 2,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Journal Name',
                        ),
                      ),
                      SizedBox(
                        height: Sizes.spaceBtwInputFields / 2,
                      ),
                      TextField(
                        controller: bioController,
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
                          RoundedContainer(
                            backgroundColor: offWhite,
                            child: Padding(
                              padding: const EdgeInsets.all(Sizes.sm),
                              child: Row(
                                children: [
                                  Image.asset(
                                    Images.journal,
                                    width: 30,
                                    height: 30,
                                  ),
                                  Text(
                                    'Select Jouranl Cover: ',
                                    style: TextStyle(
                                        color: brown,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: Sizes.md),
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
                confirmText: 'Add',
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
                    // journalCtrl.addJournalCard(Journal(
                    //   name: nameController.text,
                    //   imageName: imageName,
                    //   year: DateTime.now().year.toString(),
                    //   bio: bioController.text.isNotEmpty
                    //       ? bioController.text
                    //       : null,
                    // ));
                    journalCtrl.journal.value.bio =
                        bioController.text.isNotEmpty
                            ? bioController.text
                            : null;
                    journalCtrl.journal.value.name = nameController.text;
                    journalCtrl.journal.value.year =
                        DateTime.now().year.toString();
                    journalCtrl.journal.value.imageName = imageName;
                    journalCtrl.saveJournal();
                  }
                  journalCoverCtrl.selectedImage.value = '';
                  nameController.clear();
                  bioController.clear();
                  Get.back();
                },
              );
            },
            icon: Icon(Iconsax.element_plus_copy),
          ),
          //! New quote Btn
          IconButton(
            onPressed: () {
              Get.to(() => QuoteForm());
            },
            icon: Icon(Iconsax.save_add_copy),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SectionHeading(
              //   title: 'QuoteBooks',
              //   showActionButton: false,
              //   textColor: darkBrown,
              // ),

              // SizedBox(
              //   height: Sizes.spaceBtwItems,
              // ),
              Obx(() {
                if (journalCtrl.journalCards.isEmpty) {
                  return Center(
                      child: Image.asset(
                    Images.notesGlasses,
                    height: 170,
                  ));
                } else {
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children:
                        journalCtrl.journalCards.asMap().entries.map((entry) {
                      int index = entry.key;
                      Journal journal = entry.value;
                      String imageName =
                          p.basenameWithoutExtension(journal.imageName);
                      print('image journal : ${journal.imageName}');
                      return JournalCard(
                        journal: journal,
                        image: imageName,
                        onDelete: () => showDeleteDialog(
                            journal.id.toString()), // Pass delete method
                      );
                    }).toList(),
                  );
                }
              }),
              SizedBox(
                height: Sizes.spaceBtwItems,
              ),

              SectionHeading(
                title: 'My Quotes',
                textColor: dark ? offWhite : darkBrown,
                showActionButton: true,
                onPressed: () => Get.to(() => QuotesPage()),
              ),
              // SizedBox(
              //   child: Image.asset(Images.quoteLetters),
              // ),

              Obx(() {
                if (ctrl.allQuotesIsLoading.value) {
                  return Center(
                    child: Image.asset(
                      width: 90,
                      Images.coffeeLoading,
                    ),
                  );
                } else if (ctrl.quotes.isEmpty) {
                  return Center(child: Image.asset(Images.quoteCoffee));
                } else {
                  return SingleChildScrollView(
                    child: MyGridLayout(
                      mainAxisSpacing: Sizes.md,
                      crossAxisCount: 1,
                      itemCount: ctrl.quotes.length,
                      itemBuilder: (_, index) {
                        print(jsonEncode(ctrl.quotes[index]));
                        Quote quote = ctrl.quotes[index];
                        if (ctrl.quotes.length == 0) {
                          return Padding(
                            padding: const EdgeInsets.all(Sizes.md),
                            child: Column(
                              children: [
                                Text(
                                  'you don\'t have any quotes yet ..',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Center(child: Image.asset(Images.quoteLetters)),
                              ],
                            ),
                          );
                        } else {
                          return QuoteCard(quote: quote);
                        }
                      },
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
