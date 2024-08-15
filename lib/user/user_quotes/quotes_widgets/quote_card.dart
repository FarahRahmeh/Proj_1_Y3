import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/user/user_quotes/journal/journal_controller.dart';
import 'package:booktaste/user/user_quotes/quote_controller.dart';
import 'package:booktaste/user/user_quotes/quote_model..dart';
import 'package:booktaste/user/user_quotes/quotes_widgets/previw_quote_page.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/popups/dialogs.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../utils/constans/colors.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class QuoteCard extends StatelessWidget {
  QuoteCard({
    super.key,
    required this.quote,
    this.onSelected = _noop,
    this.isSelected = false,
    this.isDeleteMode = false,
  });
  final Quote quote;
  final ValueChanged<bool> onSelected;
  final bool isSelected;
  final bool isDeleteMode;

  static void _noop(bool value) {}

  final JournalController journalCtrl = Get.put(JournalController());

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return InkWell(
      onTap: () {
        Get.to(() => QuotePreviewPage(quote: quote));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: dark ? lightBrown : gray),
          borderRadius: BorderRadius.circular(14),
          color: dark
              ? lightBrown.withOpacity(0.7)
              : lightBrown
                  .withOpacity(0.1), //lightBrown.withOpacity(0.6), // Sara
        ),
        padding: EdgeInsets.all(Sizes.xs),
        margin: EdgeInsets.only(top: Sizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SizedBox(
            //   height: Sizes.xs,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PaperHole(),
                PaperHole(),
                PaperHole(),
                PaperHole(),
                PaperHole(),
                PaperHole(),
                PaperHole(),
              ],
            ),
            Text(
              quote.quote.length > 30
                  ? '“' + quote.quote.substring(0, 30) + '”...'
                  : '“${quote.quote}”',
            ),

            SizedBox(
              height: Sizes.xs,
            ),
            Text(quote.bookTitle.length +
                        quote.author.length +
                        quote.page.toString().length <
                    30
                ? '-${quote.bookTitle} by ${quote.author}, ${quote.page}'
                : '-${quote.bookTitle.substring(0, 8) + '..'} by ${quote.author}, ${quote.page}'),
            SizedBox(
              height: Sizes.sm,
            ),
            //! thoughts and image
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    children: [
                      quote.image == "/" || quote.image.isEmpty
                          ? RoundedImage(
                              applyImageRadius: false,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              imageUrl: Images.notesHand,
                            )
                          : CachedNetworkImage(
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                              imageUrl: '$baseImageUrl${quote.image}',
                              errorWidget: (context, url, error) {
                                print(quote.image);
                                return SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: Center(
                                      // child: Image(
                                      //   image: AssetImage(Images.quoteDefault),
                                      // ),
                                      ),
                                );
                              },
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: Icon(Iconsax.warning_2_copy),
                              ),
                            ),
                    ],
                  ),
                ),
                Flexible(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: quote.thoughts.isEmpty ? 0 : Sizes.md),
                        child: Text(
                          quote.thoughts.length > 100
                              ? quote.thoughts.substring(0, 75) + '.....'
                              : '${quote.thoughts}',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Sizes.xs / 2,
            ),

            //! icons buttons and date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Checkbox(
                  //   value: isSelected,
                  //   onChanged: (value) {
                  //     onSelected(value ?? false);
                  //   },
                  // ),
                  if (isDeleteMode)
                    Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        onSelected(value ?? false);
                      },
                    ),
                  //! date
                  // Text(
                  //   quote.sourceId.toString(),
                  //   style: Theme.of(context)
                  //       .textTheme
                  //       .labelSmall!
                  //       .apply(color: beige),
                  // ),
                  // SizedBox(
                  //   width: Sizes.md,
                  // ),
                  //! delete
                  IconButton(
                      icon: Icon(Iconsax.trash_copy,
                          color: dark ? beige : darkBrown),
                      onPressed: () {
                        MyDialogs.defaultDialog(
                          context: context,
                          title: 'Delete quote',
                          content: Text(
                              "Are you sure you want to delete this quote?"),
                          showOnlyOnConfirm: false,
                          onConfirm: () {
                            final ctrl = Get.put(QuoteController());
                            ctrl.removeQuote(quote.quoteId.toString());
                            Get.back();
                          },
                        );
                      }),

                  //! Add to quotebook
                  IconButton(
                    icon: Icon(
                      Iconsax.note_favorite_copy,
                      color: dark ? beige : darkBrown,
                    ),
                    onPressed: () {
                      showJournalSelectionDialog(context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void showJournalSelectionDialog(BuildContext context) {
    journalCtrl.fetchAllJournals();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          if (journalCtrl.journalLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return AlertDialog(
            title: Text('Add to Journal'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Add this quote to journal :'),
                      SizedBox(
                        height: Sizes.md,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.notesGlasses,
                        width: 90,
                        height: 90,
                      ),
                    ],
                  ),
                  Column(
                    children: journalCtrl.journalCards.map((journal) {
                      return ListTile(
                        leading: Icon(
                          Iconsax.document_like_copy,
                          color: brown,
                        ),
                        title: Text(journal.name),
                        onTap: () {
                          journalCtrl.addQuoteToJournal(
                              journal.id, quote.quoteId);
                          Get.back();
                        },
                      );
                    }).toList(),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}

class PaperHole extends StatelessWidget {
  const PaperHole({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Container(
      margin: EdgeInsets.only(bottom: Sizes.sm, top: Sizes.xs),
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: gray),
        color: dark ? MyColors.black : offWhite,
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.normal,
            color: dark
                ? lightBrown.withOpacity(0.2)
                : Colors.black.withOpacity(0.2), // Shadow color
            offset: Offset(1, 1), // Shadow direction
            blurRadius: 1.0, // Softness of the shadow
            spreadRadius: 0.1, // How much the shadow spreads
          ),
        ],
      ),
    );
  }
}
