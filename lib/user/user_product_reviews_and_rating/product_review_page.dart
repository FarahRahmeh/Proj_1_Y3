import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_rating/user_rating_controller.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_page.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/feedback_controller.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_with_reply_card.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../user_product_details/user_product_details_widgets/bottom_add_to_cart.dart';
import 'user_product_reviews_rating_widgets/overall_product_rating.dart';
import 'user_product_reviews_rating_widgets/rating_bar_indicator.dart';
import 'user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_controller.dart';
import 'user_product_reviews_rating_widgets/user_review_reply_card/user_review_card.dart';

class ProductReviewsPage extends StatelessWidget {
  final Book book;
  // final FeedbackController feedbackController = Get.put(FeedbackController());
  final GetFeedbackController feedcontroller = Get.put(GetFeedbackController());
  ProductReviewsPage({
    Key? key,
    required this.book,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    feedcontroller.fetchfeedback(book.id); // Load feedbacks when the page opens

    return Scaffold(
      bottomNavigationBar: BottomAddToBtn(
        title1: 'Add Review!',
        onPressed1: () {
          Get.to(() => Addfeedback(bookid: book.id));
        },
      ),
      appBar: MyAppBar(
        title: Text('Reviews & Ratings'),
        showBackArrow: true,
      ),
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
                    'Ratings and Reviews are verified and are from people who use the same type of device that you use.',
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),

                  OverallProductRating(
                    book: book,
                  ),
                  // Text(
                  //   '${ratecontroller.numofvotes}',
                  //   style: Theme.of(context).textTheme.bodySmall,
                  // ),
                  SizedBox(
                    height: Sizes.spaceBtwItems / 2,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Obx(() {
                if (feedcontroller.isLoading.value) {
                  return CircularProgressIndicator();
                } else if (feedcontroller.feedbacksList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(Sizes.md),
                    child: Column(
                      children: [
                        Text(
                          'No Feedbacks yet......',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Center(
                            child: Image.asset(dark
                                ? Images.feedbackDark
                                : Images.feedbackLight)),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: feedcontroller.feedbacksList
                        .map((feedback) => UserReviewCard(
                              feedback: feedback,
                              book: book,
                              bookid: book.id,
                            ))
                        .toList(),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
