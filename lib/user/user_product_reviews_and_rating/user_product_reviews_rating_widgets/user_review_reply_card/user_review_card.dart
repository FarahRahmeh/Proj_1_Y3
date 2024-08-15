import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/rating_bar_indicator.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_model.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_controller.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/delete_feedback.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';

import '../../../../models/book.dart';
import '../../../../utils/constans/images.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/dialogs.dart';
import 'add_feedback/feedback_controller.dart';
import 'like_dislike_feedback/like_dislike_controller.dart';

class UserReviewCard extends StatelessWidget {
  final FeedbackG feedback;
  final Like_dislikeController likedislikeController = Get.find();
  final DeleteFeedbackRepository delete = Get.put(DeleteFeedbackRepository());
  final feed = Get.put(GetFeedbackController());
  final bookid;

  Book book;

  UserReviewCard({
    Key? key,
    required this.feedback,
    required this.book,
    required this.bookid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return Column(
      children: [
        Container(
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
                      SizedBox(width: Sizes.spaceBtwItems),
                      Text(
                        '${feedback.userName}',
                        style: Theme.of(context).textTheme.titleLarge!.apply(
                              color: dark ? lightBrown : brown,
                            ),
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
                  // MyRatingBarIndicator(rating: 2, itemSize: 14),
                  SizedBox(height: Sizes.spaceBtwItems),
                  Text(
                    '${feedback.createdAt.year}-${feedback.createdAt.month}-${feedback.createdAt.day} ${feedback.createdAt.hour}:${feedback.createdAt.minute}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              SizedBox(height: Sizes.spaceBtwItems),
              ReadMoreText(
                feedback.feedback,
                numLines: 1,
                readMoreText: 'Read more',
                readLessText: 'Less',
                readMoreIconColor: dark ? lightBrown : pinkish,
                readMoreTextStyle: TextStyle(
                  color: dark ? lightBrown : brown,
                  fontSize: 12,
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      MyDialogs.defaultDialog(
                          context: context,
                          title: 'Delete Feedback',
                          content: Text(
                              'Are you sure you wont to delete your feedback?'),
                          onConfirm: () {
                            delete.deleteFeedback(feedback.id);
                            Get.back();
                            feed.fetchfeedback(bookid);
                          },
                          onCancel: () => Get.back(),
                          confirmText: 'Delete');
                    },
                    icon: Icon(Icons.delete, size: 20, color: Colors.red),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: () {
                        likedislikeController.toggleLike();
                      },
                      icon: Icon(
                        Iconsax.like_1,
                        size: 20,
                        color: likedislikeController.isLiked.value
                            ? Colors.red
                            : Colors.grey,
                      ),
                    ),
                  ),
                  Obx(
                    () => IconButton(
                      onPressed: () {
                        likedislikeController.toggleDislike();
                      },
                      icon: Icon(
                        Iconsax.dislike_copy,
                        size: 20,
                        color: likedislikeController.isDisliked.value
                            ? Colors.blue
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: Sizes.spaceBtwItems,
        )
      ],
    );
  }
}
