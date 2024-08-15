import 'dart:io';

import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/user/user_quotes/journal/journal_controller.dart';
import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../quote_controller.dart';

class QuoteForm extends StatelessWidget {
  QuoteForm({Key? key, this.quote}) : super(key: key) {
    if (quote != null) {
      quoteCtrl.quote.value = quote!;
    }
  }
  final Quote? quote;
  final QuoteController quoteCtrl = Get.put(QuoteController());
  final JournalController journalCtrl = Get.put(JournalController());
  final _quoteFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController quoteController =
        TextEditingController(text: quote?.quote ?? '');
    TextEditingController thoughtsController =
        TextEditingController(text: quote?.thoughts ?? '');
    TextEditingController bookIdController =
        TextEditingController(text: quote?.sourceId.toString() ?? '');
    TextEditingController bookTitleController =
        TextEditingController(text: quote?.bookTitle ?? '');
    TextEditingController authorController =
        TextEditingController(text: quote?.author ?? '');
    TextEditingController pageController =
        TextEditingController(text: quote?.page.toString() ?? '');
    // final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
        appBar: MyAppBar(
          title: Text(
              quote == null ? 'Add Quote' : 'Edit Quote'), //! dynamic title
          showBackArrow: true,
          actions: [
            //! Save Button
            IconButton(
                icon: Icon(Iconsax.tick_square_copy),
                onPressed: () {
                  if (_quoteFormKey.currentState!.validate()) {
                    if (quote == null) {
                      quoteCtrl.saveQuote();
                    } else {
                      quoteCtrl.updateQuote(quote!.quoteId);
                    }
                  }
                }),

            //! More Button
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                MyDialogs.defaultDialog(
                  title: 'More Details',
                  context: context,
                  content: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Add more details about the quote:'),
                        const SizedBox(
                          height: Sizes.spaceBtwInputFields / 2,
                        ),
                        //! id
                        TextField(
                          controller: bookIdController,
                          onChanged: (value) =>
                              quoteCtrl.quote.value.sourceId = value,
                          decoration: InputDecoration(
                            labelText: 'Book ID',
                          ),
                        ),
                        const SizedBox(
                          height: Sizes.spaceBtwInputFields / 2,
                        ),
                        //! title
                        TextField(
                          controller: bookTitleController,
                          onChanged: (value) =>
                              quoteCtrl.quote.value.bookTitle = value,
                          decoration: InputDecoration(labelText: 'Book Title'),
                        ),
                        const SizedBox(
                          height: Sizes.spaceBtwInputFields / 2,
                        ),
                        //! author
                        TextField(
                          controller: authorController,
                          onChanged: (value) =>
                              quoteCtrl.quote.value.author = value,
                          decoration: InputDecoration(labelText: 'Author'),
                        ),
                        const SizedBox(
                          height: Sizes.spaceBtwInputFields / 2,
                        ),
                        //! page
                        TextField(
                          controller: pageController,
                          onChanged: (value) => quoteCtrl.quote.value.page =
                              int.tryParse(value) ?? 0,
                          decoration:
                              InputDecoration(labelText: 'Page of the Quote'),
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(
                          height: Sizes.spaceBtwInputFields / 2,
                        ),

                        Text(
                          'If you enter Book ID ,no need to enter title and author',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .apply(color: MyColors.darkGrey),
                        ),
                      ],
                    ),
                  ),
                  confirmText: "Ok",
                  cancelText: 'Cancel',
                  showOnlyOnConfirm: false,
                  onConfirm: () {
                    Get.back();
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              },
            ),
          ],
        ),
        body: LayoutBuilder(builder: (context, BoxConstraints) {
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Padding(
                padding: const EdgeInsets.all(Sizes.defaultSpace),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        //! Quote and Thoughts Space
                        child: Column(
                          children: [
                            Form(
                              key: _quoteFormKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: quoteController,
                                    onChanged: (value) =>
                                        quoteCtrl.quote.value.quote = value,
                                    decoration: InputDecoration(
                                      hintText: 'Quote....',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Quote is required';
                                      }
                                      return null;
                                    },
                                    maxLines: null,
                                    minLines: 5,
                                  ),
                                  const SizedBox(
                                      height: Sizes.spaceBtwInputFields),
                                  TextFormField(
                                    controller: thoughtsController,
                                    onChanged: (value) =>
                                        quoteCtrl.quote.value.thoughts = value,
                                    decoration: InputDecoration(
                                      hintText: 'Your Thoughts ...',
                                    ),
                                    maxLines: null,
                                    minLines: 12,
                                  ),
                                  const SizedBox(
                                    height: Sizes.spaceBtwInputFields / 2,
                                  ),
                                  // Row(
                                  //   children: [
                                  //     //! id
                                  //     Expanded(
                                  //       child: TextField(
                                  //         controller: bookIdController,
                                  //         onChanged: (value) => quoteCtrl
                                  //             .quote.value.sourceId = value,
                                  //         decoration: InputDecoration(
                                  //           labelText: 'Book ID',
                                  //         ),
                                  //       ),
                                  //     ),
                                  //     const SizedBox(
                                  //       width: Sizes.spaceBtwInputFields / 2,
                                  //     ),

                                  //     //! page
                                  //     Expanded(
                                  //       child: TextField(
                                  //         controller: pageController,
                                  //         onChanged: (value) => quoteCtrl
                                  //             .quote
                                  //             .value
                                  //             .page = int.tryParse(value) ?? 0,
                                  //         decoration: InputDecoration(
                                  //             labelText: 'Page of the Quote'),
                                  //         keyboardType: TextInputType.number,
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // const SizedBox(
                                  //   height: Sizes.spaceBtwInputFields / 2,
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     //! title
                                  //     Expanded(
                                  //       child: TextField(
                                  //         controller: bookTitleController,
                                  //         onChanged: (value) => quoteCtrl
                                  //             .quote.value.bookTitle = value,
                                  //         decoration: InputDecoration(
                                  //             labelText: 'Book Title'),
                                  //       ),
                                  //     ),
                                  //     const SizedBox(
                                  //       width: Sizes.spaceBtwInputFields / 2,
                                  //     ),
                                  //     //! author
                                  //     Expanded(
                                  //       child: TextField(
                                  //         controller: authorController,
                                  //         onChanged: (value) => quoteCtrl
                                  //             .quote.value.author = value,
                                  //         decoration: InputDecoration(
                                  //             labelText: 'Author'),
                                  //       ),
                                  //     ),
                                  //     const SizedBox(
                                  //       height: Sizes.spaceBtwInputFields / 2,
                                  //     ),
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: Sizes.spaceBtwItems),
                            Obx(
                              () => Container(
                                // width: 100.0.wp,
                                // height: 16.0.hp,
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: MyColors.grey),
                                //     borderRadius: BorderRadius.circular(14)),
                                child: quoteCtrl.isImageUploading.value
                                    ? CircularProgressIndicator(
                                        color: lightBrown)
                                    : quoteCtrl.quote.value.image == '' ||
                                            quoteCtrl.quote.value.image == '/'
                                        ? //! Gallery Button

                                        IconButton(
                                            icon: Icon(
                                                Iconsax.gallery_favorite_copy),
                                            onPressed: () {
                                              quoteCtrl.pickImage();
                                            },
                                          )
                                        : Column(
                                            children: [
                                              quote != null
                                                  ? quote!.image == "/"
                                                      ? Icon(Iconsax
                                                          .gallery_favorite_copy)
                                                      : quote!.image.startsWith(
                                                              '/quotes')
                                                          ? CachedNetworkImage(
                                                              fit: BoxFit.cover,
                                                              imageUrl:
                                                                  '$baseImageUrl${quote!.image}',
                                                              errorWidget:
                                                                  (context, url,
                                                                      error) {
                                                                print(quote!
                                                                    .image);
                                                                return SizedBox(
                                                                  child:
                                                                      Center(),
                                                                );
                                                              },
                                                              progressIndicatorBuilder:
                                                                  (context, url,
                                                                          progress) =>
                                                                      Center(
                                                                child: Icon(Iconsax
                                                                    .warning_2_copy),
                                                              ),
                                                            )
                                                          : Image.file(
                                                              File(quoteCtrl
                                                                  .quote
                                                                  .value
                                                                  .image),
                                                              fit: BoxFit
                                                                  .contain)
                                                  : Image.file(
                                                      File(quoteCtrl
                                                          .quote.value.image),
                                                      fit: BoxFit.contain),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      icon: Icon(
                                                          Iconsax.trash_copy),
                                                      onPressed: () {
                                                        MyDialogs.defaultDialog(
                                                          context: context,
                                                          title: 'Remove',
                                                          content: Text(
                                                              "Are you sure you want to remove this image?"),
                                                          showOnlyOnConfirm:
                                                              false,
                                                          onConfirm: () {
                                                            quoteCtrl
                                                                .deleteImage();
                                                            Get.back();
                                                          },
                                                        );
                                                      }),
                                                  IconButton(
                                                      icon: Icon(Iconsax
                                                          .maximize_4_copy),
                                                      onPressed: () {
                                                        quoteCtrl
                                                            .previewImage();
                                                      }),
                                                ],
                                              ),
                                            ],
                                          ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }));
  }

  // void showJournalSelectionDialog(BuildContext context) {
  //   journalCtrl.fetchAllJournals();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Obx(() {
  //         if (journalCtrl.journalLoading.value) {
  //           return Center(child: CircularProgressIndicator());
  //         }

  //         return AlertDialog(
  //           title: Text('Select Journal'),
  //           content: SingleChildScrollView(
  //             child: Column(
  //               children: journalCtrl.journalCards.map((journal) {
  //                 return ListTile(
  //                   title: Text(journal.name),
  //                   onTap: () {
  //                     journalCtrl.addQuoteToJournal(journal.id,
  //                         quoteCtrl.quote.value.quoteId);
  //                     Get.back();
  //                   },
  //                 );
  //               }).toList(),
  //             ),
  //           ),
  //         );
  //       });
  //     },
  // );
  // }
}
