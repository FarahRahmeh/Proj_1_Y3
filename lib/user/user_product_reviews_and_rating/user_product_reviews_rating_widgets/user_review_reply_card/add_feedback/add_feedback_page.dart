import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_model.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/add_feedback/add_feedback_controller.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/user_product_reviews_rating_widgets/user_review_reply_card/user_review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../user_review_with_reply_card.dart';
import 'feedback_controller.dart';

class Addfeedback extends StatelessWidget {
  Addfeedback({
    super.key,
    this.bookid,
  });
  final bookid;
  final TextEditingController _textController = TextEditingController();
  final FeedbackController feedbackController = Get.find();
  final feed = Get.put(GetFeedbackController());
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add your feedback'),
      content: TextField(
        controller: _textController,
        decoration: InputDecoration(hintText: "write here"),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('cansel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('submit'),
          onPressed: () {
            String enteredText = _textController.text;
            print(" $enteredText");
            feedbackController.putFeedback(enteredText, bookid);
            feed.fetchfeedback(bookid);
            Navigator.of(context).pop();
            // Get.to(() => UserReviewWithReplyCard());
          },
        ),
      ],
    );
  }
}
