import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_with_reply_card.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../user_product_details/user_product_details_widgets/bottom_add_to_cart.dart';
import 'user_product_reviews_rating_widgets/overall_product_rating.dart';
import 'user_product_reviews_rating_widgets/rating_bar_indicator.dart';

class ProductReviewsPage extends StatelessWidget {
  ProductReviewsPage({
    Key? key,
    required this.book,
  }) : super(key: key);
  final Book book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAddToBtn(
        title1: 'Add Review!',
        onPressed1: () {},
      ),
      //! Appbar
      appBar: MyAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
      //! Body
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: Sizes.defaultSpace,
                  right: Sizes.defaultSpace,
                  left: Sizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ratings and Rrviews are verified and are from people who user the same type of device that you ues.',
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),

                  ///! Overall Product Ratings
                  OverallProductRating(),
                  MyRatingBarIndicator(rating: 3.5),
                  SizedBox(
                    height: Sizes.spaceBtwItems / 2,
                  ),
                  Text(
                    '1,030',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems / 2,
                  )
                ],
              ),
            ),

            /// ! User reviews List (Feedback)
            /// //! it looks better without the padding ,isn't?
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  UserReviewWithReplyCard(),
                  UserReviewWithReplyCard(),
                  UserReviewWithReplyCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
