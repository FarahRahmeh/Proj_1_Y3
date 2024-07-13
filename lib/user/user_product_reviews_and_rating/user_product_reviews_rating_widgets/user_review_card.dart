import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/rating_bar_indicator.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../utils/constans/images.dart';
import '../../../utils/helpers/helper_functions.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Container(
        padding: EdgeInsets.all(Sizes.sm),
        decoration: BoxDecoration(
          color: dark ? MyColors.black : lightBrown.withOpacity(0.4),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: lightBrown.withOpacity(0.8),
                      backgroundImage: AssetImage(Images.success),
                    ),
                    SizedBox(
                      width: Sizes.spaceBtwItems,
                    ),
                    Text(
                      'Username',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: dark ? lightBrown : brown),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Iconsax.more_copy),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyRatingBarIndicator(rating: 2, itemSize: 14),
                SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
                Text(
                  '01 Nov, 2024',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            ReadMoreText(
              'like it...........................................................................................................',
              numLines: 1,
              readMoreText: 'Read more',
              readLessText: 'Less',
              readMoreIconColor: dark ? lightBrown : pinkish,
              readMoreTextStyle:
                  TextStyle(color: dark ? lightBrown : brown, fontSize: 12),
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.like_1,
                    size: 20,
                  ), //~change to Iconsax.like_1_copy
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Iconsax.dislike_copy,
                    size: 20,
                  ), //~ change to Iconsax.dislike
                ),
              ],
            )
          ],
        ));
  }
}
