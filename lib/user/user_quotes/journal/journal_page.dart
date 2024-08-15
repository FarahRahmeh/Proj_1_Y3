import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/user/user_quotes/journal/add_new_journal.dart';
import 'package:booktaste/user/user_quotes/journal/journal_card.dart';
import 'package:booktaste/user/user_quotes/journal/journal_controller.dart';
import 'package:booktaste/user/user_quotes/journal/journal_model.dart';
import 'package:booktaste/user/user_quotes/quotes_widgets/quote_card.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key, required this.journal});
  final Journal journal;

  @override
  Widget build(BuildContext context) {
    final journalCtrl = Get.put(JournalController());
    journalCtrl.fetchJournalQuotes(journal.id);
    return Scaffold(
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text('${journal.name.toUpperCase()} JOURNAL'),
        actions: [
          journal.name.toString() == 'general'
              ? SizedBox.shrink()
              : NewJournal(
                  journal: journal,
                ),
          journal.name.toString() == 'general'
              ? SizedBox.shrink()
              : Obx(() {
                  return IconButton(
                    icon: Icon(journalCtrl.isRemoveMode.value
                        ? Iconsax.close_circle_copy
                        : Iconsax.trash),
                    onPressed: () {
                      journalCtrl.toggleRemoveMode();
                    },
                  );
                }),
          journal.name.toString() == 'general'
              ? SizedBox.shrink()
              : Obx(() {
                  return journalCtrl.isRemoveMode.value
                      ? IconButton(
                          icon: Icon(Iconsax.trash),
                          onPressed: () {
                            journalCtrl.confirmRemove(journal.id);
                          },
                        )
                      : SizedBox.shrink();
                }),
        ],
      ),
      body: Obx(() {
        if (journalCtrl.journalLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: lightBrown),
          );
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: JournalCard(
                    journal: journal,
                    name: journal.name,
                    onDelete: () {},
                    image: journal.imageName,
                    height: 210,
                    width: 165,
                  ),
                ),
                SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                if (journal.bio != 'null' && journal.bio!.isNotEmpty)
                  Center(
                    child: Text(
                      // 'Bio: ${journal.bio}',
                      ' ${journal.bio}',
                      style: TextStyle(
                        fontSize: Sizes.fontSizeMd,
                      ),
                    ),
                  ),
                SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  'Journal Quotes:',
                  style: TextStyle(
                    fontSize: Sizes.fontSizeLg,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (journalCtrl.journalQuotes.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(Sizes.md),
                    child: Column(
                      children: [
                        Text(
                          'No Quotes in this journal yet..',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Center(child: Image.asset(Images.quoteCoffee)),
                      ],
                    ),
                  )
                else
                  // ...journalCtrl.journalQuotes
                  //     .map((quote) => QuoteCard(
                  //           quote: quote,
                  //         ))
                  //     .toList(),

                  // ...journalCtrl.journalQuotes
                  //     .map((quote) => Obx(() {
                  //           final isSelected = journalCtrl
                  //               .selectedQuotesToDelete
                  //               .contains(quote.quoteId);

                  //           return QuoteCard(
                  //             quote: quote,
                  //             isSelected: isSelected,
                  //             onSelected: (selected) {
                  //               if (selected) {
                  //                 journalCtrl.selectedQuotesToDelete
                  //                     .add(quote.quoteId);
                  //               } else {
                  //                 journalCtrl.selectedQuotesToDelete
                  //                     .remove(quote.quoteId);
                  //               }
                  //             },
                  //           );
                  //         }))
                  //     .toList(),
                  ...journalCtrl.journalQuotes
                      .map((quote) => QuoteCard(
                            quote: quote,
                            isDeleteMode: journalCtrl.isRemoveMode.value,
                            isSelected: journalCtrl.selectedQuotesToRemove
                                .contains(quote.quoteId),
                            onSelected: (isSelected) {
                              journalCtrl.toggleQuoteSelection(
                                  quote.quoteId, isSelected);
                            },
                          ))
                      .toList(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
