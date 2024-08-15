import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/like_dislike_feedback/like_dislike_feedback_repositories.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class Like_dislikeController extends GetxController {
  var isLiked = false.obs;
  var isDisliked = false.obs;
  

  void toggleLike() async {
    if (isLiked.value) {
      isLiked.value = false;
    } else {
      isLiked.value = true;
      isDisliked.value = false;
    }
  }

  void toggleDislike() async {
    if (isDisliked.value) {
      isDisliked.value = false;
    } else {
      isDisliked.value = true;
      isLiked.value = false;
    }
  }
}
