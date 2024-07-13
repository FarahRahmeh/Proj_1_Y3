import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import 'reply_to_review_card.dart';
import 'user_review_card.dart';

class UserReviewWithReplyCard extends StatelessWidget {
  const UserReviewWithReplyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Column(
      children: [
        //!Divider
        Divider(
          color: dark ? beige2 : MyColors.grey,
        ),
        //! the feedback with reply card
        RoundedContainer(
          radius: 0,
          padding: EdgeInsets.all(10),
          backgroundColor:
              dark ? lightBrown.withOpacity(0.4) : beige2.withOpacity(0.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Sizes.spaceBtwItems,
              ),

              ///!Review
              UserReviewCard(),
              SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              //! Company Review
              ReplyToReviewCard(),
              // SizedBox(
              //   height: Sizes.spaceBtwSections / 2,
              // )
            ],
          ),
        ),
      ],
    );
  }
}
