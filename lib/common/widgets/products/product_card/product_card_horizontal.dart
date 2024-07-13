import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/icons/locked_icon.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/common/widgets/texts/x_title_text.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../models/book_model.dart';
import '../../../../user/user_product_details/product_details_page.dart';
import '../../../../utils/constans/api_constans.dart';
import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../styles/shadows.dart';
import '../../icons/circular_icon.dart';
import '../../icons/favourite_icon.dart';
import '../../texts/product_price.dart';

class ProductCardHorizontal extends StatelessWidget {
  const ProductCardHorizontal({
    super.key,
    required this.allbooks,
  });
  final AllBooks allbooks;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsPage(
          //  bookId: allbooks.id.toString(),
          )),
      child: Container(
        margin: EdgeInsets.all(4),
        width: 320,
        //180
        decoration: BoxDecoration(
          // boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(Sizes.productImageRadius),
          border: Border.all(color: dark ? lightBrown : Colors.transparent),
          color: dark ? MyColors.black : beige2.withOpacity(0.4),
        ),
        child: Row(
          children: [
            //! -- Thumbnail
            RoundedContainer(
              showBorder: true,
              borderColor: beige2.withOpacity(0.4),
              height: 120,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark ? Colors.transparent : offWhite,
              child: Stack(
                children: [
                  //! --Thumbnail Image
                  SizedBox(
                    height: 120,
                    width: 120,
                    child: RoundedImage(
                      isNetworkImage: allbooks.cover == '/' ? false : true,
                      //imageUrl: Images.cover6,
                      imageUrl: allbooks.cover == '/'
                          ? Images.cover6
                          : '$baseUrl${allbooks.cover}',
                      // applyImageRadius: true,
                    ),
                  ),
                  //! -- Locked tag
                  Positioned(
                      top: 0,
                      // left: -30,
                      child: LockedIcon()),
                  //! Favourite Icon Button
                  Positioned(
                    //*to control the position
                    top: 0,
                    right: 0,
                    child: FavouriteIcon(),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //! Title
                        ProductTitleText(
                          title: allbooks.name,
                          //title: 'Harry Potter and the Chamber of Secrets',
                          smallSize: true,
                        ),
                        SizedBox(
                          height: Sizes.spaceBtwItems / 2,
                        ),
                        //! Author
                        XTitleText(
                          title: allbooks.writer,
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
                          child: ProductPriceText(
                            title: '${allbooks.stars} Rating',
                            color: pinkish,
                          ),
                        ),
                        // !Add to
                        Container(
                          decoration: BoxDecoration(
                            color: lightBrown,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Sizes.cardRadiusMd),
                              bottomRight:
                                  Radius.circular(Sizes.productImageRadius),
                            ),
                          ),
                          child: SizedBox(
                            width: Sizes.iconLg * 1.2,
                            height: Sizes.iconLg * 1.2,
                            child: Center(
                                child: Icon(Icons.add, color: MyColors.white)),
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
