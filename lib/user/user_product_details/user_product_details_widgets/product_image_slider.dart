import 'package:booktaste/common/widgets/images/network_image.dart';
import 'package:booktaste/user/user_own_lists/favourite_list/favourite_list_controller.dart';
import 'package:booktaste/user/user_own_lists/single_book_in_lists/book_in_lists_controller.dart';
import 'package:booktaste/user/user_own_lists/single_book_in_lists/book_in_lists_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../data/services/role.manager.dart';
import '../../../utils/constans/colors.dart';
import '../../../utils/constans/images.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../common/widgets/appbar/appbar.dart';
import '../../../common/widgets/custom_shapes/curved_edges/curved_edge_widget.dart';
import '../../../common/widgets/icons/circular_icon.dart';

class ProductImageSlider extends StatelessWidget {
  ProductImageSlider({super.key, required this.imageurl, required this.id});
  final String imageurl;
  final String id;
  final bookShelfController = Get.put(BookListsController());

  @override
  Widget build(BuildContext context) {
    final favCtrl = Get.put(FavouriteController());
    final dark = HelperFunctions.isDarkMode(context);
    return CurvedEdgeWidget(
      child: Container(
        color: dark ? MyColors.darkestGrey : MyColors.light,
        child: Stack(
          children: [
            ///! Main large image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(Sizes.productImageRadius * 2),
                child: Center(
                    child: MyNetworkImage(
                  imageUrl: imageurl,
                  notFoundImage: Images.defaultBookCover,
                  fit: BoxFit.cover,
                  shHeight: 380,
                  shWidth: 210,
                )),
              ),
            ),

            ///! Image Slider
            // Positioned(
            //   right: 0,
            //   bottom: 40,
            //   left: Sizes.defaultSpace,
            //   child: SizedBox(
            //     height: 80,
            //     child: ListView.separated(
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       itemCount: 5,
            //       separatorBuilder: (_, __) => SizedBox(
            //         width: Sizes.spaceBtwItems,
            //       ),
            //       itemBuilder: (_, index) => RoundedImage(
            //           width: 80,
            //           border: Border.all(color: beige2),
            //           padding: EdgeInsets.all(Sizes.sm),
            //           backgroundColor:
            //               dark ? Colors.transparent : MyColors.white,
            //           imageUrl: Images.cover4),
            //     ),
            //   ),
            // ),

            ///! Appbar
            MyAppBar(
              showBackArrow: true,
              actions: [
                FutureBuilder<bool>(
                  future: isUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: lightBrown,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final user = snapshot.data;
                      //! fav icon
                      return user == true
                          ? FutureBuilder<bool>(
                              future: favCtrl.checkIfIsFav(id),
                              builder: (builder, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      color: lightBrown,
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  final isFav = snapshot.data;
                                  return CircularIcon(
                                    backgroundColor: offWhite.withOpacity(0.9),
                                    icon: isFav == true
                                        ? Iconsax.heart
                                        : Iconsax.heart_copy,
                                    color: pinkish,
                                    onPressed: () => favCtrl.addToFavourite(id),
                                  );
                                }
                              })
                          : SizedBox.shrink();
                    }
                  },
                ),
                SizedBox(
                  width: Sizes.md,
                ),
                FutureBuilder<bool>(
                  future: isUser(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(
                        color: lightBrown,
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final user = snapshot.data;
                      //!
                      return user == true
                          ? CircularIcon(
                              // backgroundColor: offWhite.withOpacity(0.9),
                              icon: Iconsax.folder_2,
                              color: lightBrown,
                              onPressed: () {
                                showBookLists(context);
                                // Get.to(() => BookInListsView(
                                //       bookid: id,
                                //     ));
                                // // showModalBottomSheet(
                                // //     context: context,
                                // //     builder: (context) => MyBottomSheet(
                                // //           title: 'Add this book to :',
                                // //
                              },
                            )
                          : SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showBookLists(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    bookShelfController.fetchBookLists(id.toString());
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          if (bookShelfController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return AlertDialog(
            backgroundColor: offWhite,
            title: Text(
              'This Book Exist in:',
              style: TextStyle(color: brown),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text('Add this quote to journal :'),
                  //     SizedBox(
                  //       height: Sizes.md,
                  //     )
                  //   ],
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Images.shelves,
                        width: 90,
                        height: 90,
                      ),
                    ],
                  ),
                  bookShelfController.bookLists.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No List',
                              style: TextStyle(color: brown),
                            ),
                          ],
                        )
                      : Column(
                          children: bookShelfController.bookLists.map((list) {
                            return ListTile(
                              leading: Icon(
                                Iconsax.folder_copy,
                                color: brown,
                              ),
                              title: Text(
                                list,
                                style: TextStyle(color: brown),
                              ),
                            );
                          }).toList(),
                        ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: TextStyle(color: darkBrown),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      },
    );
  }
}
