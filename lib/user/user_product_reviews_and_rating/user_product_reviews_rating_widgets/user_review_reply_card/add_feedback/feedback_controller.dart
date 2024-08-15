import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_model.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_repositories.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class GetFeedbackController extends GetxController {
  var isLoading = true.obs;
  var feedbacksList = <FeedbackG>[].obs;

  @override
  void onInit() {
    super.onInit();

  }

  void fetchfeedback(int bookid) async {
    try {
      isLoading.value = true;
      var feedbacks = await FeedbackRepository.getFeedbacks(bookid);
      if (feedbacks != null) {
        print("not null feed");
        feedbacksList.value = feedbacks;
      }
    } catch (e) {
      print(e);
    } finally {
      print('no');
      isLoading.value = false;
    }
  }
}
