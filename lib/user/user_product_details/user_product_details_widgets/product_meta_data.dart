import 'dart:convert';
import 'dart:math';

import 'package:booktaste/models/book.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../common/widgets/custom_shapes/Containers/rounded_container.dart';
import '../../../utils/helpers/helper_functions.dart';

class ProductMetaData extends StatelessWidget {
  ProductMetaData({
    Key? key,
    required this.book,
  }) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    final Random random = Random();

    print('in meta data' + jsonEncode(book));
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            //! Price
            // Text(
            //   '\$250',
            //   style: Theme.of(context)
            //       .textTheme
            //       .titleSmall!
            //       .apply(decoration: TextDecoration.lineThrough),
            // ),
            // const SizedBox(width: Sizes.spaceBtwItems),
            // const ProductPriceText(price: '175'),
            // // , isLarge: true),
          ],
        ),
        // const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        //!pages
        Row(
          //! this center work
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RoundedContainer(
              radius: Sizes.sm,
              backgroundColor: gray.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.sm, vertical: Sizes.xs),
              child: Text(
                '${book.pages} pages',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: MyColors.black),
              ),
            ),
            const SizedBox(width: Sizes.spaceBtwItems / 1.5),

            //! novel
            RoundedContainer(
              radius: Sizes.sm,
              backgroundColor: gray.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.sm, vertical: Sizes.xs),
              child: Text(
                book.type == '1' ? 'Novel' : 'Book',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .apply(color: MyColors.black),
              ),
            ),
            //! language
            const SizedBox(width: Sizes.spaceBtwItems / 1.5),
            RoundedContainer(
              radius: Sizes.sm,
              backgroundColor: gray.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.sm, vertical: Sizes.xs),
              child: Row(
                children: [
                  Icon(
                    Iconsax.global_copy,
                    size: 16,
                  ),
                  Text(
                    ' ${book.lang}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: MyColors.black),
                  ),
                ],
              ),
            ),
            //! year of publication
            const SizedBox(width: Sizes.spaceBtwItems / 1.5),
            RoundedContainer(
              radius: Sizes.sm,
              backgroundColor: gray.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.sm, vertical: Sizes.xs),
              child: Row(
                children: [
                  Icon(
                    Iconsax.calendar_1_copy,
                    size: 16,
                  ),
                  Text(
                    ' ${book.publicationYear}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: MyColors.black),
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('genres :', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(width: Sizes.spaceBtwItems),
            Expanded(
              child: Wrap(
                // spacing: 4.0, // Horizontal spacing between genres
                // runSpacing: 4.0, // Vertical spacing between lines of genres
                children: book.genre.asMap().entries.map((entry) {
                  final Color genreColor =
                      colorList[random.nextInt(colorList.length)];
                  return GestureDetector(
                    // onTap: () {
                    //   Get.to(() => SubCategoriesPage(genre: entry.value));
                    // },
                    child: RoundedContainer(
                      borderColor: MyColors.darkGrey,
                      showBorder: true,
                      margin: EdgeInsets.all(Sizes.xs),
                      radius: Sizes.sm,
                      backgroundColor: genreColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: Sizes.sm, vertical: Sizes.xs),
                      child: Text(
                        '${entry.value}',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .apply(color: dark ? offWhite : MyColors.black),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
