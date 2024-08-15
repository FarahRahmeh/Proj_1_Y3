import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_model.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_repositories.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FeedbackController extends GetxController {
  var isLoading = true.obs;
  var feedbackText = ''.obs;
  var feedbackList = <FeedbackP>[].obs;
  

  @override
  void onInit() {
    super.onInit();
  }

  void putFeedback(String feedback, int id) async {
    try {
      isLoading(true);
      var feed = await FeedbackRepository.putFeedback(feedback, id);
      if (feed != null) {
        feedbackList.add(feed);
      }
    } finally {
      isLoading(false);
    }
  }

}
