import 'package:booktaste/common/widgets/bottom_sheet/my_bottom_sheet.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/user/user_product_details/user_product_details_widgets/product_meta_data.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/product_review_page.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';
import '../../admin/manage_books/add_book/manage_book_controller.dart';
import '../../models/book.dart';
import '../../utils/constans/colors.dart';
import '../../utils/helpers/helper_functions.dart';
import '../../utils/popups/dialogs.dart';
import 'user_product_details_widgets/bottom_add_to_cart.dart';
import 'user_product_details_widgets/product_image_slider.dart';
import 'user_product_details_widgets/product_ratings_and_share.dart';

class ProductDetailsPage extends StatelessWidget {
  ProductDetailsPage({Key? key, required this.bookId, required this.book})
      : super(key: key);

  final String bookId;
  final Book book;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    final bookController = Get.put(BookDetailsController());
    return Scaffold(
        //!bottom bar
        bottomNavigationBar: FutureBuilder<bool>(
          future: isUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final isUser = snapshot.data ?? true;
              return isUser
                  ? BottomAddToBtn(
                      title1: 'Add this book to',
                      onPressed1: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) => MyBottomSheet(
                                  title: 'Add this book to :',
                                ));
                      },
                    )
                  : BottomAddToBtn(
                      twoBtns: true,
                      title1: 'Edit',
                      title2: 'Delete',
                      onPressed1: () {},
                      onPressed2: () {
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
                            final ctrl = Get.put(ManageBookController());
                            ctrl.removeBook(bookId.toString());
                            Get.back();
                            Get.back();
                          },
                        );
                      },
                    );
            }
          },
        ),
        body: FutureBuilder<Book?>(
            future: bookController.fetchBookDetails(bookId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: darkBrown,
                  backgroundColor: lightBrown,
                ));
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                print(snapshot.data);
                final book = snapshot.data;
                if (book == null) {
                  return const Text('Book null in vertical');
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ///! 1--- Product Image slider
                        ProductImageSlider(
                          imageurl: book.cover,
                        ),

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
                                rate: book.rate.toString(),
                                votersNum: book.votersNum.toString(),
                              ),

                              ///! -Price , Title ,stock , & brand
                              ProductMetaData(
                                book: book,
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
                              // Obx(() =>
                              ReadMoreText(
                                //'summary',
                                book.summary,
                                // bookController.book.summary,
                                //  book.summary,
                                numLines: 5,
                                readMoreText: 'Show more',
                                readLessText: 'Less',
                                readMoreIconColor: pinkish,
                                readMoreTextStyle:
                                    TextStyle(color: dark ? lightBrown : brown),
                                style: TextStyle(
                                    fontWeight: FontWeight.w300, fontSize: 14),
                              ),
                              // ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SectionHeading(
                                    title: 'Reviews (222)',
                                    showActionButton: false,
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        Get.to(() => ProductReviewsPage(
                                              book: book,
                                            )),
                                    icon:
                                        const Icon(Iconsax.arrow_right_3_copy),
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
                  );
                }
              }
            }));
  }
}
