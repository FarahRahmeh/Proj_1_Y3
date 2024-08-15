import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../models/book.dart';
import 'rating_progress_indicator.dart';
import 'user_rating/user_rating_controller.dart';
import 'user_rating/user_rating_model.dart';
import 'user_rating/user_rating_repositories.dart';

class OverallProductRating extends StatelessWidget {
  OverallProductRating({
    super.key,
    required this.book,
  });

  final Book book;
  final ratecontroller = Get.put(RateController());
  final controller = Get.put(RateRepository());

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Obx(()
           => Text(
            
              '${ratecontroller.stars}',
              style: Theme.of(context).textTheme.displayLarge,
            ),
          ),
        ),
        Column(
          children: [
            Text('Your Rate',
                style: Theme.of(context).textTheme.titleLarge!.apply(
                      color: dark ? lightBrown : brown,
                    )),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                ratecontroller.updateRating(rating);
              },
            ),
            SizedBox(height: Sizes.spaceBtwItems),
            ElevatedButton(
              onPressed: () {
                ratecontroller.fetchrate(book.id);
              },
              style: ElevatedButton.styleFrom(
                  padding:
                      EdgeInsets.only(top: 5, bottom: 5, left: 60, right: 60)),
              child: Text('Submit'),
            ),
          ],
        ),

        // Expanded(
        //   flex: 7,
        //   child: Column(
        //     children: [
        //       RatingProgressIndicator(text: '5', value: 1.0),
        //       RatingProgressIndicator(text: '4', value: 0.8),
        //       RatingProgressIndicator(text: '3', value: 0.6),
        //       RatingProgressIndicator(text: '2', value: 0.4),
        //       RatingProgressIndicator(text: '1', value: 0.2),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
