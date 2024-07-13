import 'package:booktaste/common/widgets/images/circular_image.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/custom_shapes/Containers/rounded_container.dart';
import '../../../common/widgets/texts/product_price.dart';
import '../../../utils/helpers/helper_functions.dart';

class ProductMetaData extends StatelessWidget {
  const ProductMetaData(
      {super.key,
      required this.title,
      required this.author,
      required this.pages,
      required this.language,
      required this.pubAt,
      required this.readers,
      required this.type,
      required this.points,
      required this.readingTime,
      required this.genres});
  final String title;
  final String author;
  final String pages;
  final String language;
  final List<dynamic> genres;
  final String pubAt;
  final String readers;
  final String type;
  final String points;
  final String readingTime;

  @override
  Widget build(BuildContext context) {
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
          children: [
            ProductTitleText(title: 'Book Title :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        //!Stack status
        Row(
          children: [
            ProductTitleText(title: 'Author :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              author,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(title: 'number of pages :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              pages,
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
              language,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),
        Row(
          children: [
            ProductTitleText(title: 'genres :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Wrap(
              children: genres.asMap().entries.map((entry) {
                int index = entry.key;
                String genre = entry.value;
                bool isLast = index == genres.length - 1;

                String separator = isLast ? '.' : ', ';

                return Text(
                  genre + separator,
                  style: Theme.of(context).textTheme.titleMedium,
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 1.5),

        Row(
          children: [
            ProductTitleText(title: 'Published Year :'),
            const SizedBox(width: Sizes.spaceBtwItems),
            Text(
              pubAt,
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
              readers,
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
              type,
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
              points,
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
              readingTime,
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
