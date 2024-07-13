import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../utils/helpers/helper_functions.dart';

class ReplyToReviewCard extends StatelessWidget {
  const ReplyToReviewCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return RoundedContainer(
      backgroundColor: dark ? MyColors.black.withOpacity(0.6) : gray,
      child: Padding(
        padding: EdgeInsets.all(Sizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'BookTaste',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: dark ? lightBrown : darkBrown),
                ),
                Text(
                  '02 Nov, 2023',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            ReadMoreText(
              'Thank u...........................................................................................................',
              numLines: 2,
              readMoreText: 'Show more',
              readLessText: 'Less',
              readMoreIconColor: pinkish,
              readMoreTextStyle: TextStyle(color: brown),
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
