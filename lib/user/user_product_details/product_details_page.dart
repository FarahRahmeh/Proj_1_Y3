import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/user/user_product_details/user_product_details_widgets/product_meta_data.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/product_review_page.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';
// import 'package:readmore/readmore.dart';

import '../../utils/constans/colors.dart';
import 'user_product_details_widgets/bottom_add_to_cart.dart';
import 'user_product_details_widgets/product_attributes.dart';
import 'user_product_details_widgets/product_image_slider.dart';
import 'user_product_details_widgets/product_ratings_and_share.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///! 1--- Product Image slider
            ProductImageSlider(),

            ///! 2--- Product Details
            Padding(
              padding: const EdgeInsets.only(
                  right: Sizes.defaultSpace,
                  left: Sizes.defaultSpace,
                  bottom: Sizes.defaultSpace),
              child: Column(
                children: [
                  ///! -Rating & Share
                  RatingsAndShare(),

                  ///! -Price , Title ,stock , & brand
                  ProductMetaData(),

                  ///! -Attributes
                  ProductAttributes(),
                  SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),

                  ///! -Checkout button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text('Checkout'),
                    ),
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),

                  ///! -Description
                  SectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    'This is a very long text to demo the usages of this package\n'
                    'This is a very long text to demo the usages of this package'
                    'This is a very long text to demo the usages of this package'
                    'This is a very long text to demo the usages of this package',
                    numLines: 4,
                    readMoreText: 'Show more',
                    readLessText: 'Less',
                    readMoreIconColor: pinkish,
                    readMoreTextStyle: TextStyle(color: brown),
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                  ),
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
                        onPressed: () =>
                            Get.to(() => const ProductReviewsPage()),
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
      ),
    );
  }
}
