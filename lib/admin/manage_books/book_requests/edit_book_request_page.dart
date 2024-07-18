
import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';


class EditBookRequestPage extends StatelessWidget {
  const EditBookRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    // final controller = Get.put(ManageBookController());

    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Edit Book Requests ',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Form(
            //  key: controller.addBookFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // //! Image Picker
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       children: [
                //         PopupMenuButton(
                //           color: MyColors.lightGrey,
                //           onSelected: (value) {
                //             if (value == 'pick') {
                //               controller.pickImage();
                //             } else if (value == 'preview') {
                //               if (controller.imageUrl.value ==
                //                       Images.defaultBookCover ||
                //                   controller.imageUrl.value.isEmpty) {
                //                 Loaders.customToast(
                //                     message:
                //                         'Please pick a cover to preview it! 🤗');
                //               } else {
                //                 controller.previewImage();
                //               }
                //             } else if (value == 'delete') {
                //               if (controller.imageUrl.isEmpty ||
                //                   controller.imageUrl.value ==
                //                       Images.defaultBookCover) {
                //                 Loaders.customToast(
                //                     message:
                //                         'There is already no cover to be deleted .. 🙄');
                //               } else {
                //                 controller.imageUrl.value =
                //                     Images.defaultBookCover;
                //               }
                //             }
                //           },
                //           itemBuilder: (context) => [
                //             PopupMenuItem(
                //               value: 'pick',
                //               child: Row(
                //                 children: [
                //                   Icon(Iconsax.gallery_add_copy,
                //                       color: dark ? offWhite : lightBrown),
                //                   SizedBox(width: 8),
                //                   Text('Pick Cover Image'),
                //                 ],
                //               ),
                //             ),
                //             PopupMenuItem(
                //               value: 'preview',
                //               child: Row(
                //                 children: [
                //                   Icon(Iconsax.export_3_copy,
                //                       color: dark ? brown : lightBrown),
                //                   SizedBox(width: 8),
                //                   Text('Preview Cover'),
                //                 ],
                //               ),
                //             ),
                //             PopupMenuItem(
                //               value: 'delete',
                //               child: Row(
                //                 children: [
                //                   Icon(Iconsax.trash_copy,
                //                       color: dark ? offWhite : pinkishMore),
                //                   SizedBox(width: 8),
                //                   Text('Delete Cover'),
                //                 ],
                //               ),
                //             ),
                //           ],
                //           child: InkWell(
                //             child: RoundedContainer(
                //               backgroundColor: lightBrown.withOpacity(0.6),
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     height: 30,
                //                     width: 100,
                //                     margin: EdgeInsets.all(Sizes.xs),
                //                     child: Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceEvenly,
                //                       children: [
                //                         Icon(Iconsax.gallery_add_copy,
                //                             size: 18, color: brown),
                //                         Text('Book Cover'),
                //                       ],
                //                     ),
                //                   ),
                //                   Obx(() => Container(
                //                         height: 130,
                //                         width: 100,
                //                         margin: EdgeInsets.all(Sizes.xs),
                //                         decoration: BoxDecoration(
                //                           borderRadius:
                //                               BorderRadius.circular(14),
                //                           color: Theme.of(context)
                //                               .colorScheme
                //                               .background
                //                               .withOpacity(0.2),
                //                         ),
                //                         child: Center(
                //                           child: controller
                //                                   .isImageUploading.value
                //                               ? CircularProgressIndicator(
                //                                   color: lightBrown)
                //                               : controller.imageUrl.value ==
                //                                       Images.defaultBookCover
                //                                   ? ClipRRect(
                //                                       borderRadius:
                //                                           BorderRadius.circular(
                //                                               14),
                //                                       child: Image.asset(
                //                                           Images
                //                                               .defaultBookCover,
                //                                           fit: BoxFit.cover),
                //                                     )
                //                                   : ClipRRect(
                //                                       borderRadius:
                //                                           BorderRadius.circular(
                //                                               14),
                //                                       child: Image.file(
                //                                           File(controller
                //                                               .imageUrl.value),
                //                                           fit: BoxFit.cover),
                //                                     ),
                //                         ),
                //                       )),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //     //! File Picker
                //     PopupMenuButton(
                //       color: MyColors.lightGrey,
                //       onSelected: (value) {
                //         if (value == 'pick') {
                //           controller.pickPdf();
                //         } else if (value == 'delete') {
                //           if (controller.pdfUrl.isEmpty) {
                //             Loaders.customToast(
                //                 message:
                //                     'There is already no file to be deleted .. 🙄');
                //           } else {
                //             controller.pdfUrl.value = "";
                //           }
                //         }
                //       },
                //       itemBuilder: (context) => [
                //         PopupMenuItem(
                //           value: 'pick',
                //           child: Row(
                //             children: [
                //               Icon(Iconsax.document_upload_copy,
                //                   color: dark ? offWhite : lightBrown),
                //               SizedBox(width: 8),
                //               Text('Pick Book Pdf file'),
                //             ],
                //           ),
                //         ),
                //         // PopupMenuItem(
                //         //   value: 'preview',
                //         //   child: Row(
                //         //     children: [
                //         //       Icon(Iconsax.export_3_copy,
                //         //           color: dark ? brown : lightBrown),
                //         //       SizedBox(width: 8),
                //         //       Text('Preview Cover'),
                //         //     ],
                //         //   ),
                //         // ),
                //         PopupMenuItem(
                //           value: 'delete',
                //           child: Row(
                //             children: [
                //               Icon(Iconsax.trash_copy,
                //                   color: dark ? offWhite : pinkishMore),
                //               SizedBox(width: 8),
                //               Text('Clear selected file'),
                //             ],
                //           ),
                //         ),
                //       ],
                //       child: InkWell(
                //         child: RoundedContainer(
                //           backgroundColor: lightBrown.withOpacity(0.6),
                //           child: Column(
                //             children: [
                //               Container(
                //                 height: 30,
                //                 width: 100,
                //                 margin: EdgeInsets.all(Sizes.xs),
                //                 child: Row(
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceEvenly,
                //                   children: [
                //                     Icon(
                //                       Iconsax.document_upload_copy,
                //                       size: 18,
                //                       color: brown,
                //                     ),
                //                     Text('Book PDF'),
                //                   ],
                //                 ),
                //               ),
                //               Obx(
                //                 () => Container(
                //                   height: 130,
                //                   width: 100,
                //                   margin: EdgeInsets.all(Sizes.xs),
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(14),
                //                     color: Theme.of(context)
                //                         .colorScheme
                //                         .background
                //                         .withOpacity(0.2),
                //                   ),
                //                   child: Center(
                //                     child: controller.isPdfUploading.value
                //                         ? CircularProgressIndicator(
                //                             color: lightBrown,
                //                           )
                //                         : controller.pdfUrl.value == ""
                //                             ? ClipRRect(
                //                                 borderRadius:
                //                                     BorderRadius.circular(14),
                //                                 child: Icon(Iconsax.add_circle),
                //                               )
                //                             : ClipRRect(
                //                                 borderRadius:
                //                                     BorderRadius.circular(14),
                //                                 child:
                //                                     Icon(Iconsax.tick_circle),
                //                               ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ), //! image
                //     Image.asset(
                //       Images.corner,
                //       width: 122,
                //     ),
                //   ],
                // ),
                // const SizedBox(height: Sizes.spaceBtwInputFields),

                // //!Title
                // TextFormField(
                //   controller: controller.titleController,
                //   decoration: const InputDecoration(
                //     prefixIcon: Icon(Iconsax.book_1_copy),
                //     labelText: 'Book title',
                //   ),
                //   validator: (value) =>
                //       Validator.validateEmptyText(value, 'Book title'),
                // ),
                // const SizedBox(height: Sizes.spaceBtwInputFields),
                // //! Author
                // TextFormField(
                //   controller: controller.authorController,
                //   decoration: const InputDecoration(
                //       prefixIcon: Icon(Iconsax.path_copy), labelText: 'Author'),
                //   validator: (value) =>
                //       Validator.validateEmptyText(value, 'Author name'),
                // ),

                // //!num of pages
                // const SizedBox(height: Sizes.spaceBtwInputFields),
                // Row(children: [
                //   Expanded(
                //     child: TextFormField(
                //       controller: controller.pagesController,
                //       keyboardType: TextInputType.number,
                //       decoration: const InputDecoration(
                //         prefixIcon: Icon(Iconsax.paperclip_2_copy),
                //         labelText: 'Pages',
                //       ),
                //     ),
                //   ),

                //   //!Publication Year
                //   SizedBox(width: Sizes.spaceBtwInputFields),
                //   Expanded(
                //     child: TextFormField(
                //       controller: controller.pubYearController,
                //       keyboardType: TextInputType.number,
                //       maxLength: 4,
                //       decoration: InputDecoration(
                //           hintText: 'YYYY ',
                //           hintStyle: TextStyle(color: gray),
                //           counterText: '',
                //           counterStyle: TextStyle(
                //             fontSize: 12,
                //             color: gray,
                //           ),
                //           prefixIcon: Icon(Iconsax.calendar_1_copy),
                //           labelText: 'Publication Year'),
                //     ),
                //   ),
                // ]),

                // //! Language
                // const SizedBox(height: Sizes.spaceBtwInputFields),
                // Obx(() => RoundedContainer(
                //       backgroundColor: dark ? MyColors.black : offWhite,
                //       height: 65,
                //       borderColor: gray,
                //       showBorder: true,
                //       child: Center(
                //         child: ListTile(
                //           // textColor: dark ? offWhite : brown,
                //           leading: Icon(
                //             Iconsax.text_copy,
                //             color: gray,
                //           ),
                //           title: Text.rich(
                //             TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: 'Language : ',
                //                   style: TextStyle(
                //                     color: dark
                //                         ? offWhite
                //                         : brown.withOpacity(0.6),
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${controller.selectedLanguage.value}',
                //                   style: TextStyle(
                //                     color: dark ? offWhite : brown,
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           trailing: Icon(
                //             Iconsax.global_edit_copy,
                //             color: gray,
                //           ),
                //           onTap: () {
                //             return MyDialogs.defaultDialog(
                //               showOnlyOnConfirm: true,
                //               confirmText: 'Ok',
                //               context: context,
                //               title: 'Choose book langauge:',
                //               content: Obx(
                //                 () => SingleChildScrollView(
                //                   child: Column(
                //                     mainAxisSize: MainAxisSize.min,
                //                     children:
                //                         controller.languages.map((language) {
                //                       return RadioListTile<String>(
                //                         title: Text(language),
                //                         value: language,
                //                         groupValue:
                //                             controller.selectedLanguage.value,
                //                         onChanged: (value) {
                //                           if (value != null) {
                //                             controller.selectedLanguage.value =
                //                                 value;
                //                           }
                //                         },
                //                       );
                //                     }).toList(),
                //                   ),
                //                 ),
                //               ),
                //               onConfirm: () {
                //                 Get.back();
                //               },
                //             );
                //           },
                //         ),
                //       ),
                //     )),
                // const SizedBox(height: Sizes.spaceBtwInputFields),
                // //! points
                // Row(
                //   children: [
                //     Obx(() {
                //       return controller.isLocked.value
                //           ? Expanded(
                //               child: TextFormField(
                //                 controller: controller.pointsController,
                //                 keyboardType: TextInputType.number,
                //                 decoration: const InputDecoration(
                //                   prefixIcon: Icon(Iconsax.coin_1_copy),
                //                   labelText: 'Points',
                //                 ),
                //               ),
                //             )
                //           : SizedBox.shrink();
                //     }),
                //   ],
                // ),

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     //!Novel or not
                //     Obx(
                //       () => Checkbox(
                //           value: controller.isNovel.value,
                //           onChanged: (value) => controller.isNovel.value =
                //               !controller.isNovel.value),
                //     ),
                //     const Text('Novel'),
                //     //! locked or not
                //     Obx(
                //       () => Checkbox(
                //           value: controller.isLocked.value,
                //           onChanged: (value) => controller.isLocked.value =
                //               !controller.isLocked.value),
                //     ),
                //     const Text('Lock with points'),
                //   ],
                // ),
                // //! genres
                // const SizedBox(width: Sizes.spaceBtwInputFields),
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //     MyDropdownBtnFormField(
                //       hintText: "Genres",
                //       prefixIconColor: gray,
                //       validator: (value) {
                //         if (controller.selecedGenres.isEmpty) {
                //           return 'Please choose one genre at least';
                //         } else {
                //           return null;
                //         }
                //       },
                //       prefixIcon: Iconsax.color_swatch_copy,
                //       items: controller.genres,
                //       onChanged: (String? newValue) {
                //         if (newValue != null) {
                //           controller.addGenre(newValue);
                //         }
                //       },
                //     ),
                //     SizedBox(height: Sizes.spaceBtwInputFields / 2),
                //     Obx(
                //       () => Wrap(
                //         spacing: 4,
                //         children: controller.selecedGenres.map((choice) {
                //           return MyChoiceChip(
                //               text: choice,
                //               selected: true,
                //               onSelected: (bool selected) {
                //                 controller.removeGenre(choice);
                //               });
                //         }).toList(),
                //       ),
                //     ),
                //     //),
                //   ],
                // ),
                // //! Summary
                // //! Expanded TextFormField
                // const SizedBox(height: Sizes.spaceBtwInputFields / 2),
                // // SizedBox(
                // //   height: 100,
                // //   child: Column(
                // //     children: [
                // //       Expanded(
                // //         flex: 1,
                // //         child:
                // TextFormField(
                //   controller: controller.summaryController,
                //   // minLines: null,
                //   maxLines: null,
                //   // expands: true,
                //   decoration: InputDecoration(
                //     prefixIcon: Icon(
                //       Iconsax.note_text_copy,
                //     ),
                //     labelText: 'Summary ',
                //     hintText: 'Summary or Discription of the book ',
                //     hintStyle: TextStyle(color: gray),
                //   ),
                // ),
                // //       ),
                // //     ],
                // //   ),
                // // ),
                // const SizedBox(height: Sizes.spaceBtwInputFields),
                // //! Save Button
                // const SizedBox(height: Sizes.defaultSpace),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       controller.saveBook();
                //     },
                //     child: Text('Save'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
