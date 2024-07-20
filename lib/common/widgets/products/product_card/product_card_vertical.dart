import 'dart:convert';

import 'package:booktaste/admin/manage_books/add_book/manage_book_controller.dart';
import 'package:booktaste/common/styles/shadows.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/popup_menu_button/my_popup_menu_button.dart';
import 'package:booktaste/common/widgets/shimmers/shimmer.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';

import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/user/user_product_details/product_details_page.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../utils/popups/dialogs.dart';
import '../../bottom_sheet/my_bottom_sheet.dart';
import '../../icons/circular_icon.dart';
import '../../icons/locked_icon.dart';
import '../../texts/product_price.dart';
import '../../texts/title_with_icon.dart';

class ProductCardVertical extends StatelessWidget {
  ProductCardVertical({super.key, required this.allbooks});

  final AllBooks allbooks;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    //~ Container with side padding ,color, edges, radius and shadow.
    return FutureBuilder<bool>(
        future: isUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString() + 'Error');
          } else {
            final user = snapshot.data ?? true;
            return GestureDetector(
              onTap: () {
                final bookCtrl = Get.put(BookDetailsController());
                bookCtrl.fetchBookDetails(allbooks.id
                    .toString()); //This is what fixed the problem that the first time to click on the card(on first restart) no book details shows up
                final book = bookCtrl.book;

                Get.to(() => ProductDetailsPage(
                      book: book,
                      bookId: allbooks.id.toString(),
                    ));
                print('All Books:$allbooks' +
                    jsonEncode(allbooks) +
                    'book id in product card vertical before navigation to product details page' +
                    jsonEncode(book));
              },
              child: Container(
                margin: EdgeInsets.all(4),
                width: 160,
                //180
                decoration: BoxDecoration(
                  boxShadow: [ShadowStyle.verticalProductShadow],
                  border: Border.all(
                      color: dark
                          ? lightBrown
                          : Colors.transparent), //Colors.transparent
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
                            width: 90,
                            height: 170,
                            //  isNetworkImage: allbooks.cover == '/' ? false : true,
                            imageUrl: allbooks.cover,
                            isNetworkImage: true,
                            shHeight: 130,
                            shWidth: 100,
                            // networkChild: allbooks.cover == '/'
                            //     ? Center(
                            //         child: Image(
                            //             image: AssetImage(
                            //                 Images.defaultBookCover)))
                            //     : CachedNetworkImage(
                            //         fit: BoxFit.cover,
                            //         imageUrl: '$baseImageUrl${allbooks.cover}',
                            //         errorWidget: (context, url, error) =>
                            //             SizedBox(
                            //           width: 20,
                            //           height: 20,
                            //           child: Center(
                            //               child: Icon(Iconsax.warning_2_copy)),
                            //         ),
                            //         progressIndicatorBuilder:
                            //             (context, url, progress) => Center(
                            //           child: ShimmerEffect(
                            //             height: 130,
                            //             width: 100,
                            //           ),
                            //         ),
                            //       ),
                            // imageUrl: allbooks.cover == '/'
                            //     ? Images.cover6
                            //     : '$baseUrl${allbooks.cover}',
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
                            child: user == true
                                ? CircularIcon(
                                    backgroundColor:
                                        beige2.withOpacity(dark ? 0.2 : 0.7),
                                    icon: Iconsax.heart,
                                    color: pinkish,
                                  )
                                : SizedBox.shrink(),
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
                            maxLines: 1,
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
                        user == true
                            ? GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (context) => MyBottomSheet(
                                            title: 'Add this book to :',
                                          ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: lightBrown,
                                    borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(Sizes.cardRadiusMd),
                                      bottomRight: Radius.circular(
                                          Sizes.productImageRadius),
                                    ),
                                  ),
                                  child: SizedBox(
                                    width: Sizes.iconLg * 1.2,
                                    height: Sizes.iconLg * 1.2,
                                    child: Center(
                                      child: Icon(Icons.add,
                                          color: MyColors.white),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  color: lightBrown,
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(Sizes.cardRadiusMd),
                                    bottomRight: Radius.circular(
                                        Sizes.productImageRadius),
                                  ),
                                ),
                                child: SizedBox(
                                  width: Sizes.iconLg * 1.2,
                                  height: Sizes.iconLg * 1.2,
                                  child: MyPopupMenuButton(
                                    menuItems: [
                                      MyPopupMenuOption(
                                        label: 'Edit',
                                        icon: Iconsax.edit_2_copy,
                                        iconColor: dark ? offWhite : lightBrown,
                                        onTap: () {
                                          // Add your edit logic here
                                        },
                                      ).getMenuItem(context),
                                      MyPopupMenuOption(
                                        label: 'Delete',
                                        icon: Iconsax.trash_copy,
                                        iconColor: dark ? brown : pinkishMore,
                                        onTap: () {
                                          MyDialogs.defaultDialog(
                                            context: context,
                                            title: 'Delete Book',
                                            content: Text(
                                              'Are you sure you want to delete this book from BookTaste?\nYou can not undo this',
                                            ),
                                            cancelText: 'Cancel',
                                            confirmText: 'Delete',
                                            onCancel: () => Get.back(),
                                            onConfirm: () {
                                              final ctrl = Get.put(
                                                  ManageBookController());
                                              ctrl.removeBook(
                                                  allbooks.id.toString());
                                              Get.back();
                                            },
                                          );
                                        },
                                      ).getMenuItem(context),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
