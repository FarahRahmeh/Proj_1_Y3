import 'dart:io';

import 'package:booktaste/admin/manage_books/manage_book_controller.dart';
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/choice_chip/my_choice_chip.dart';
import 'package:booktaste/common/widgets/dropdown_button_form_field/my_dorpdown_btn_form_field.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart';

class AddNewBookPage extends StatelessWidget {
  const AddNewBookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManageBookController());

    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Add New Book',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            key: controller.addBookFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //! file picker

              //! summary

              children: [
                //! Image Picker
                Column(
                  children: [
                    Text('Book cover'),
                    InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: Obx(
                        () => Container(
                          height: 130,
                          width: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Theme.of(context).colorScheme.background,
                          ),
                          child: Center(
                            child: controller.isImageUploading.value
                                ? CircularProgressIndicator(
                                    color: lightBrown,
                                  )
                                : controller.imageUrl.value ==
                                        Images.defaultBookCover
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset(
                                          Images.defaultBookCover,
                                          fit: BoxFit.cover,
                                        ))
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.file(
                                          File(controller.imageUrl.value),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),

                //!Title
                TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.book_1_copy),
                    labelText: 'Book title',
                  ),
                  validator: (value) =>
                      Validator.validateEmptyText(value, 'Book title'),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                //! Author
                TextFormField(
                  controller: controller.authorController,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Iconsax.path_copy), labelText: 'Author'),
                  validator: (value) =>
                      Validator.validateEmptyText(value, 'Author name'),
                ),
                //!num of pages
                const SizedBox(height: Sizes.spaceBtwInputFields),
                Row(children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.pagesController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Iconsax.paperclip_2_copy),
                        labelText: 'Pages',
                      ),
                    ),
                  ),

                  //!Publication Year
                  SizedBox(width: Sizes.spaceBtwInputFields),
                  Expanded(
                    child: TextFormField(
                      controller: controller.pubYearController,
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      decoration: InputDecoration(
                          hintText: 'YYYY ',
                          hintStyle: TextStyle(color: gray),
                          counterText: '',
                          counterStyle: TextStyle(
                            fontSize: 12,
                            color: gray,
                          ),
                          prefixIcon: Icon(Iconsax.calendar_1_copy),
                          labelText: 'Published at'),
                    ),
                  ),
                ]),
                //! points
                const SizedBox(height: Sizes.spaceBtwInputFields),
                Row(
                  children: [
                    Obx(() {
                      return controller.isLocked.value
                          ? Expanded(
                              child: TextFormField(
                                controller: controller.pointsController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Iconsax.coin_1_copy),
                                  labelText: 'Points',
                                ),
                              ),
                            )
                          : SizedBox.shrink();
                    }),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //!Novel or not
                    Obx(
                      () => Checkbox(
                          value: controller.isNovel.value,
                          onChanged: (value) => controller.isNovel.value =
                              !controller.isNovel.value),
                    ),
                    const Text('Novel'),
                    //! locked or not
                    Obx(
                      () => Checkbox(
                          value: controller.isLocked.value,
                          onChanged: (value) => controller.isLocked.value =
                              !controller.isLocked.value),
                    ),
                    const Text('Lock with points'),
                  ],
                ),
                //! genres
                const SizedBox(width: Sizes.spaceBtwInputFields),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyDropdownBtnFormField(
                      hintText: "Genres",
                      prefixIconColor: gray,
                      prefixIcon: Iconsax.color_swatch_copy,
                      items: controller.genres,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.addGenre(newValue);
                        }
                      },
                    ),
                    SizedBox(height: Sizes.spaceBtwInputFields / 2),
                    Obx(
                      () =>
                          // Padding(
                          //   padding:
                          //       const EdgeInsets.symmetric(horizontal: Sizes.xs),
                          //   child:
                          Wrap(
                        spacing: 4,
                        children: controller.selecedGenres.map((choice) {
                          return MyChoiceChip(
                              text: choice,
                              selected: true,
                              onSelected: (bool selected) {
                                controller.removeGenre(choice);
                              });
                        }).toList(),
                      ),
                    ),
                    //),
                  ],
                ),
                //! Summary
                //! Expanded TextFormField
                const SizedBox(height: Sizes.spaceBtwInputFields / 2),
                SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: controller.summaryController,
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Iconsax.note_text_copy,
                            ),
                            labelText: 'Summary ',
                            hintText: 'Summary or Discription of the book ',
                            hintStyle: TextStyle(color: gray),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: Sizes.spaceBtwInputFields),
                //! Save Button
                const SizedBox(height: Sizes.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addBookFormKey.currentState!.validate();
                    },
                    child: Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
