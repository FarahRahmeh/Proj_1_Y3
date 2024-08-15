import 'package:booktaste/admin/manage_books/add_book/add_new_book_page.dart';
import 'package:booktaste/common/features/book_inquiry/user_send_inquiry_view.dart';
import 'package:booktaste/common/widgets/texts/section_heading.dart';
import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/controllers/book/pdf_controlller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/user/user_product_details/user_product_details_widgets/product_meta_data.dart';
import 'package:booktaste/user/user_product_reviews_and_rating/product_review_page.dart';
import 'package:booktaste/utils/constans/api_constans.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:read_more_text/read_more_text.dart';
import '../../admin/manage_books/add_book/manage_book_controller.dart';
import '../../common/features/book_inquiry/book_inquiry_page.dart';
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
    final pdfController = Get.put(PdfController());
    // final favCtrl = Get.put(FavouriteController());

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
            final user = snapshot.data ?? true;
            return user
                ? BottomAddToBtn(
                    twoBtns: false,
                    // title1: 'Add To',
                    // onPressed1: () {
                    //   // Get.to(() => BookInListsView(
                    //   //       bookid: book.id.toString(),
                    //   //     ));
                    //   // showModalBottomSheet(
                    //   //     context: context,
                    //   //     builder: (context) => MyBottomSheet(
                    //   //           title: 'Add this book to :',
                    //   //         ));
                    // },
                    onPressedRead: () async {
                      print(book!.locked);
                      if (book.locked == '0' || await user == false) {
                        await pdfController.downloadAndOpenPdf(
                          "$baseImageUrl/${book.bookFile}",
                          "${book.id}.pdf",
                        );
                      }
                    },
                    titleRead: book!.locked == '0' || user == false
                        ? 'Read'
                        : '${book.points.toString()}',
                  )
                : FutureBuilder<Book?>(
                    future: bookController.fetchBookDetails(bookId),
                    builder: (builder, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: darkBrown,
                          backgroundColor: lightBrown,
                        ));
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        final book = snapshot.data;
                        return BottomAddToBtn(
                          twoBtns: true,
                          title1: 'Edit',
                          title2: 'Delete',
                          onPressed1: () {
                            final ctrl = Get.put(ManageBookController());
                            ctrl.clearFields();
                            Get.to(() => AddNewBookPage(
                                  book: book,
                                ));
                          },
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
                          onPressedRead: () async {
                            print(book!.locked);
                            if (book.locked == '0' || await user == false) {
                              await pdfController.downloadAndOpenPdf(
                                "$baseImageUrl/${book.bookFile}",
                                "${book.id}.pdf",
                              );
                            }
                          },
                          titleRead: user == false
                              ? 'Read'
                              : book!.locked == '0'
                                  ? 'Read'
                                  : '${book.points.toString()}',
                        );
                      }
                    });
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
                      id: book.id.toString(),
                    ),

                    ///! 2--- Product Details
                    Padding(
                      padding: const EdgeInsets.only(
                          right: Sizes.defaultSpace,
                          left: Sizes.defaultSpace,
                          bottom: Sizes.defaultSpace),
                      child: Column(
                        children: [
                          //! read button

                          // SizedBox(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     onPressed: () async {
                          //       print(book.locked);
                          //       if (book.locked == '0' ||
                          //           await isUser() == false) {
                          //         Get.to(() => BookPdfViewerPage(
                          //               pdfUrl: book.id.toString(),
                          //             ));
                          //       }
                          //     },
                          //     //! need fixxxxxxxxxxxxxxxxxxxxxxxxx for admin
                          //     child: Text(
                          //         book.locked == '0' || isUser() == false
                          //             ? 'Read'
                          //             : '${book.points.toString()}'),
                          //   ),
                          // ),
                          // SizedBox(
                          //   width: double.infinity,
                          //   child: ElevatedButton(
                          //     onPressed: () async {
                          //       print(book.locked);
                          //       if (book.locked == '0' ||
                          //           await isUser() == false) {
                          //         await pdfController.downloadAndOpenPdf(
                          //           "$baseImageUrl/${book.bookFile}",
                          //           "${book.id}.pdf",
                          //         );
                          //       }
                          //     },
                          //     child: Text(
                          //         book.locked == '0' || isUser() == false
                          //             ? 'Read'
                          //             : '${book.points.toString()}'),
                          //   ),
                          // ),

                          ///! -Rating & Share & Book ID
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RatingsAndShare(
                                rate: book.rate.toString(),
                                votersNum: book.votersNum.toString(),
                              ),
                              Row(
                                children: [
                                  Tooltip(
                                    decoration: BoxDecoration(
                                      color: lightBrown,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    message: 'Book ID',
                                    child: Text(
                                      book.bookId.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                          ClipboardData(text: book.bookId));
                                      Loaders.customToast(
                                          message:
                                              'Book ID copied to clipboard 🧡');
                                    },
                                    icon: Icon(
                                      Iconsax.copy_copy,
                                      size: 15,
                                      color: lightBrown,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),

                          ///! -Title , author , type, pages, language, publication date
                          ///
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: Sizes.sm,
                              ),
                              //!Title
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.book_saved_copy,
                                    size: 15,
                                    color: dark ? offWhite : lightBrown,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      book.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Sizes.spaceBtwItems / 1.5),
                              //!author
                              Row(
                                children: [
                                  Icon(
                                    Iconsax.path_copy,
                                    size: 15,
                                    color: dark ? offWhite : lightBrown,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: Text(
                                      book.writer,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: Sizes.spaceBtwItems / 1.5),
                              ProductMetaData(
                                book: book,
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: Sizes.spaceBtwSections / 2,
                          ),

                          ///! -Description
                          SectionHeading(
                            title: 'Summary :',
                            showActionButton: false,
                          ),
                          SizedBox(
                            height: Sizes.spaceBtwItems / 2,
                          ),

                          ReadMoreText(
                            book.summary,
                            numLines: 5,
                            readMoreText: 'Show more',
                            readLessText: 'Less',
                            readMoreIconColor: lightBrown,
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
                          //! readers & avg time reading
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Text(
                                  book.readersNum != 0
                                      ? "${book.readersNum.toString()} readers"
                                      : 'No readers yet ',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              Text('  |  '),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  book.avgReadingTime.isNotEmpty
                                      ? '${book.avgReadingTime} average reading time'
                                      : ' Unknown average reading time',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
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
                                    Get.to(() => ProductReviewsPage(
                                          book: book,
                                        )),
                                icon: const Icon(Iconsax.arrow_right_3_copy),
                              ),
                            ],
                          ),
                          Divider(),
                          SizedBox(
                            height: Sizes.spaceBtwItems,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SectionHeading(
                                title: 'Inquiries',
                                showActionButton: false,
                              ),
                              IconButton(
                                onPressed: () async {
                                  final user = await isUser();
                                  Get.to(() => user == false
                                      ? BookInquiriesPage(
                                          bookId: book.id.toString(),
                                        )
                                      : SendInquiryView(
                                          bookId: book.id.toString(),
                                        ));
                                },
                                icon: const Icon(Iconsax.arrow_right_3_copy),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: Sizes.spaceBtwSections,
                          ),
                          // ElevatedButton(
                          //     onPressed: () {
                          //       final ctrl = Get.put(ManageBookController());
                          //       ctrl.clearFields();
                          //       Get.to(() => AddNewBookPage(
                          //             book: book,
                          //           ));
                          //     },
                          //     child: Text('Edit')),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
        },
      ),
    );
  }
}
