import 'package:booktaste/common/styles/shadows.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/data/repositories/book_repository.dart';
import 'package:booktaste/models/book_model.dart';

import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/user/user_product_details/product_details_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/constans/api_constans.dart';
import '../../icons/circular_icon.dart';
import '../../icons/locked_icon.dart';
import '../../images/book_cover.dart';
import '../../texts/product_price.dart';
import '../../texts/title_with_icon.dart';

class ProductCardVertical extends StatelessWidget {
  const ProductCardVertical({super.key, required this.allbooks});

  final AllBooks allbooks;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final bookCtrl = Get.find<BookDetailsController>();
    bookCtrl.fetchBookDetails(allbooks.id
        .toString()); //This is what fixed the problem that the first time to click on the card(on first restart) no book details shows up
    //
    //
    //~ Container with side padding ,color, edges, radius and shadow.
    print(allbooks.cover + 'book cover in product card vertical');
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetailsPage(
          //  bookId: allbooks.id.toString(),
          )),
      child: Container(
        margin: EdgeInsets.all(4),
        width: 160,
        //180

        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          border: Border.all(
              color:
                  dark ? lightBrown : Colors.transparent), //Colors.transparent
          borderRadius: BorderRadius.circular(Sizes.productImageRadius),
          color: dark ? MyColors.black : offWhite,
        ),
        child: Column(
          children: [
            /// !Thumbanil ,WishList button ,Discount Tag
            RoundedContainer(
              height: 160,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark
                  ? Colors.transparent
                  : MyColors.light, //~--------the card color
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  //! Thumbnail Image ........................................
                  RoundedImage(
                    isNetworkImage: allbooks.cover == '/' ? false : true,
                    //imageUrl: Images.cover6,
                    imageUrl: allbooks.cover == '/'
                        ? Images.cover6
                        : '$baseUrl${allbooks.cover}',
                    // applyImageRadius: true,
                  ),

                  //! -- Locked tag
                  Positioned(
                    top: 5,
                    left: -33,
                    child: LockedIcon(),
                  ),

                  //! Favourite Icon Button
                  Positioned(
                    //*to control the position
                    top: 0,
                    right: -30,
                    child: CircularIcon(
                      backgroundColor: beige2.withOpacity(dark ? 0.2 : 0.7),
                      icon: Iconsax.heart,
                      color: pinkish,
                    ),
                  ),
                ],
              ),
            ),

            ///!Details Title and Author
            Padding(
              padding: const EdgeInsets.only(left: Sizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //! Title
                  ProductTitleText(
                    title: allbooks.name,
                    smallSize: true,
                    fontWeightDelta: 2,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems / 2,
                  ),
                  //! Author
                  TextTitleWithIcon(
                    title: allbooks.writer,
                    textColor: dark ? beige2 : brown,
                    iconColor: dark ? beige2 : darkBrown,
                  ),
                ],
              ),
            ),
            const Spacer(),
            //! Rating Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: Sizes.sm),
                    //! Rating
                    child: ProductPriceText(
                      title: '${allbooks.stars} Rating',
                      color: pinkish,
                    )),
                //! Add to
                Container(
                  decoration: const BoxDecoration(
                    color: lightBrown,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Sizes.cardRadiusMd),
                      bottomRight: Radius.circular(Sizes.productImageRadius),
                    ),
                  ),
                  child: const SizedBox(
                    width: Sizes.iconLg * 1.2,
                    height: Sizes.iconLg * 1.2,
                    child:
                        Center(child: Icon(Icons.add, color: MyColors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
