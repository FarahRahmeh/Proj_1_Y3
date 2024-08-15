import 'dart:convert';

import 'package:booktaste/common/widgets/images/circular_image.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/custom_shapes/Containers/rounded_container.dart';
import '../../../common/widgets/texts/product_price.dart';
import '../../../utils/helpers/helper_functions.dart';

class ProductMetaData extends StatelessWidget {
  ProductMetaData({
    Key? key,
    required this.book,
  }) : super(key: key);
  final Book book;

  @override
  Widget build(BuildContext context) {
    print('in meta data' + jsonEncode(book));
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Price & Sale Price
        Row(
          children: [
            ///! Sale Tag
            // RoundedContainer(
            //   radius: Sizes.sm,
            //   backgroundColor: MyColors.secondary.withOpacity(0.8),
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: Sizes.sm, vertical: Sizes.xs),
            //   child: Text(
            //     '25%',
            //     style: Theme.of(context)
            //         .textTheme
            //         .labelLarge!
            //         .apply(color: MyColors.black),
            //   ),
            // ),
            // const SizedBox(width: Sizes.spaceBtwItems),

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
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        //!Title
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductTitleText(title: 'Book Title :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Expanded(
              child: Text(
                book.name,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        //!Stack status
        Row(
          children: [
            ProductTitleText(title: 'Author :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Expanded(
              child: Text(
                book.writer
                //author
                ,
                style: Theme.of(context).textTheme.titleMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(title: 'number of pages :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              book.pages.toString(),
              // pages,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(title: 'Language :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              book.lang,
              // language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductTitleText(title: 'genres :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Expanded(
              child: Wrap(
                // spacing: 4.0, // Horizontal spacing between genres
                // runSpacing: 4.0, // Vertical spacing between lines of genres
                children: book.genre.asMap().entries.map((entry) {
                  int index = entry.key;
                  String genre = entry.value;
                  bool isLast = index == genre.length - 1;
                  String separator = isLast ? '.' : ', ';

                  return Text(
                    genre + separator,
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        Row(
          children: [
            ProductTitleText(title: 'Published Year :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              book.publicationYear,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(title: 'Number of readers :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              book.readersNum.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(title: 'Book type :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              book.type.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(title: 'Points :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              book.points.toString(),
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(title: 'Average reading time :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              book.avgReadingTime,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        // //! Brand
        // Row(
        //   children: [
        //     // CircularImage(
        //     //   image: Images.book,
        //     //   width: 32,
        //     //   height: 32,
        //     //   // overlayColor: dark ? MyColors.white : MyColors.black,
        //     // ),
        //     Text(
        //       'Author : ',
        //       style: Theme.of(context).textTheme.titleLarge,
        //     ),
        //     // TextTitleWithIcon(
        //     //   title: 'Author  ',
        //     //   titleTextSize: TextSizes.medium,
        //     // ),
        //   ],
        // ),
      ],
    );
  }
}
