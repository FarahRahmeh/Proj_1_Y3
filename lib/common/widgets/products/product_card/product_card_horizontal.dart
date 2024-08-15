import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/icons/locked_icon.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/common/widgets/texts/x_title_text.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../admin/manage_books/add_book/manage_book_controller.dart';
import '../../../../controllers/book/book_controller.dart';
import '../../../../user/user_product_details/product_details_page.dart';
import '../../../../utils/constans/colors.dart';
import '../../../../utils/constans/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/popups/dialogs.dart';
import '../../bottom_sheet/my_bottom_sheet.dart';
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

    return FutureBuilder<bool>(
        future: isUser(),
        builder: (builder, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data ?? true;
            return GestureDetector(
              onTap: () {
                final bookCtrl = Get.put(BookDetailsController());
                bookCtrl.fetchBookDetails(allbooks.id
                    .toString()); //This is what fixed the problem that the first time to click on the card(on first restart) no book details shows up
                final book = bookCtrl.book;
                Get.to(() => ProductDetailsPage(
                      bookId: allbooks.id.toString(),
                    ));
              },
              child: Container(
                margin: EdgeInsets.all(4),
                width: 320,
                //180
                decoration: BoxDecoration(
                  // boxShadow: [ShadowStyle.verticalProductShadow],
                  borderRadius: BorderRadius.circular(Sizes.productImageRadius),
                  border:
                      Border.all(color: dark ? lightBrown : Colors.transparent),
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
                              // isNetworkImage: allbooks.cover == '/' ? false : true,
                              imageUrl: Images.cover6,
                              // imageUrl: allbooks.cover == '/'
                              //     ? Images.cover6
                              //     : '$baseUrl${allbooks.cover}',
                              // applyImageRadius: true,
                            ),
                          ),
                          //! -- Locked tag
                          Positioned(
                              top: 0,
                              // left: -30,
                              child: LockedIcon()),
                          //! Favourite Icon Button
                          user == true
                              ? Positioned(
                                  //*to control the position
                                  top: 0,
                                  right: 0,
                                  child: FavouriteIcon(),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                    //! Details
                    SizedBox(
                      width: 180,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: Sizes.sm, left: Sizes.xs),
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
                                user == true
                                    ? GestureDetector(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  MyBottomSheet(
                                                    title: 'Add this book to :',
                                                  ));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: lightBrown,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(
                                                  Sizes.cardRadiusMd),
                                              bottomRight: Radius.circular(
                                                  Sizes.productImageRadius),
                                            ),
                                          ),
                                          child: SizedBox(
                                            width: Sizes.iconLg * 1.2,
                                            height: Sizes.iconLg * 1.2,
                                            child: Center(
                                                child: Icon(Icons.add,
                                                    color: MyColors.white)),
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: lightBrown,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                Sizes.cardRadiusMd),
                                            bottomRight: Radius.circular(
                                                Sizes.productImageRadius),
                                          ),
                                        ),
                                        child: SizedBox(
                                          width: Sizes.iconLg * 1.2,
                                          height: Sizes.iconLg * 1.2,
                                          child: PopupMenuButton(
                                            icon: Icon(
                                              Icons.more_vert,
                                              color: offWhite,
                                            ),
                                            itemBuilder: (context) => [
                                              PopupMenuItem(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Icon(
                                                      Iconsax.edit_2_copy,
                                                      color: dark
                                                          ? offWhite
                                                          : lightBrown,
                                                    ),
                                                    Text('Edit'),
                                                  ],
                                                ),
                                                onTap: () {
                                                  // Add your edit logic here
                                                },
                                              ),
                                              PopupMenuItem(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Icon(
                                                      Iconsax.trash_copy,
                                                      color: dark
                                                          ? brown
                                                          : pinkishMore,
                                                    ),
                                                    Text('Delete'),
                                                  ],
                                                ),
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
                                                      ctrl.removeBook(allbooks
                                                          .id
                                                          .toString());
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
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
        });
  }
}
