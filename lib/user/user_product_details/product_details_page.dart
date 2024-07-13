import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/data/repositories/book_repository.dart';
import 'package:booktaste/user/user_product_details/user_product_details_widgets/product_meta_data.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/product_review_page.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';
import '../../models/book.dart';
import '../../utils/constans/colors.dart';
import 'user_product_details_widgets/bottom_add_to_cart.dart';
import 'user_product_details_widgets/product_attributes.dart';
import 'user_product_details_widgets/product_image_slider.dart';
import 'user_product_details_widgets/product_ratings_and_share.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({
    super.key,
  });

  // final String bookId;
  final bookController = Get.find<BookDetailsController>();

  @override
  Widget build(BuildContext context) {
    // bookController.fetchBookDetails(bookId);
    return Scaffold(

        //!bottom bar
        bottomNavigationBar: BottomAddToCart(
          title: 'Add this book to',
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ///! 1--- Product Image slider
              ProductImageSlider(imageurl: bookController.book.value.cover),

              ///! 2--- Product Details
              Padding(
                padding: const EdgeInsets.only(
                    right: Sizes.defaultSpace,
                    left: Sizes.defaultSpace,
                    bottom: Sizes.defaultSpace),
                child: Column(
                  children: [
                    ///! -Rating & Share
                    RatingsAndShare(
                        rate: bookController.book.value.rate.toString(),
                        votersNum:
                            bookController.book.value.votersNum.toString()),

                    ///! -Price , Title ,stock , & brand
                    ProductMetaData(
                      author: bookController.book.value.writer,
                      language: bookController.book.value.lang,
                      pages: bookController.book.value.pages.toString(),
                      points: bookController.book.value.points.toString(),
                      pubAt: bookController.book.value.publicationYear,
                      readers: bookController.book.value.readersNum.toString(),
                      readingTime: bookController.book.value.avgReadingTime,
                      title: bookController.book.value.name,
                      type: bookController.book.value.type,
                      genres: bookController.book.value.genre,
                    ),

                    ///! -Attributes
                    // ProductAttributes(),
                    SizedBox(
                      height: Sizes.spaceBtwSections,
                    ),

                    ///! -Checkout button
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: () {},
                    //     child: Text('Checkout'),
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: Sizes.spaceBtwSections,
                    // ),

                    ///! -Description
                    SectionHeading(
                      title: 'Summary',
                      showActionButton: false,
                    ),
                    SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    Obx(() => ReadMoreText(
                          bookController.book.value.summary,
                          numLines: 4,
                          readMoreText: 'Show more',
                          readLessText: 'Less',
                          readMoreIconColor: pinkish,
                          readMoreTextStyle: TextStyle(color: brown),
                          style: TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 14),
                        )),
                    SizedBox(
                      width: Sizes.spaceBtwSections,
                    ),

                    ///! -Reviews
                    SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    Divider(),
                    SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SectionHeading(
                          title: 'Reviews (222)',
                          showActionButton: false,
                        ),
                        IconButton(
                          onPressed: () => Get.to(() => ProductReviewsPage()),
                          icon: const Icon(Iconsax.arrow_right_3_copy),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: Sizes.spaceBtwSections,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
