import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/common/widgets/texts/x_title_text.dart';
import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/models/book.dart';
import 'package:booktaste/models/popular_book_model.dart';
import 'package:booktaste/models/rate_book.dart';
import 'package:booktaste/user/user_product_details/product_details_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../texts/product_price.dart';

class ProductTile extends StatelessWidget {
  ProductTile({super.key, this.popBook, this.rateBook});
  final PopularBook? popBook;
  final RateBook? rateBook;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () {
        final bookCtrl = Get.put(BookDetailsController());
        bookCtrl.fetchBookDetails(
            popBook != null ? popBook!.id.toString() : rateBook!.id.toString());
        final book = bookCtrl.book;
        Get.to(() => ProductDetailsPage(
              book: book,
              bookId: popBook != null
                  ? popBook!.id.toString()
                  : rateBook!.id.toString(),
            ));
      },
      child: Container(
        margin: EdgeInsets.all(4),
        width: 320,
        //180
        decoration: BoxDecoration(
          // boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(Sizes.productImageRadius),
          border: Border.all(color: dark ? lightBrown : Colors.transparent),
          color: dark ? MyColors.black : lightBrown.withOpacity(0.2),
        ),
        child: Row(
          children: [
            //! -- Thumbnail
            RoundedContainer(
              showBorder: true,
              borderColor: lightBrown.withOpacity(0.2),
              height: 120,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark ? Colors.transparent : offWhite,
              child: Stack(
                children: [
                  //! --Thumbnail Image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: Center(
                      child: RoundedImage(
                        applyImageRadius: false,
                        fit: BoxFit.cover,
                        imageUrl: popBook != null
                            ? popBook!.cover.toString()
                            : rateBook!.cover.toString(),
                        isNetworkImage: true,
                        shHeight: 100,
                        shWidth: 80,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //! Details
            SizedBox(
              width: 180,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: Sizes.sm, left: Sizes.xs),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //! Title
                        ProductTitleText(
                          title: popBook != null
                              ? popBook!.name.toString()
                              : rateBook!.name.toString(),
                          //title: 'Harry Potter and the Chamber of Secrets',
                          smallSize: true,
                        ),
                        SizedBox(
                          height: Sizes.spaceBtwItems / 2,
                        ),
                        //! Author
                        XTitleText(
                          title: popBook != null
                              ? popBook!.author.toString()
                              : rateBook!.writer.toString(),
                          color: dark ? gray : lightBrown,
                          // 'J.K. Rowling'
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems / 3,
                  ),
                  const Spacer(),
                  //! Rating Row
                  Padding(
                    padding: const EdgeInsets.only(left: Sizes.sm),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                popBook != null ? 'Read percent : ' : 'Rate:',
                                style: TextStyle(color: pinkish),
                              ),
                              ProductPriceText(
                                title: popBook != null
                                    ? '${popBook!.readPercent.toString().substring(0, 4)} %'
                                    : '${rateBook!.stars} ',
                                color: pinkishMore,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
