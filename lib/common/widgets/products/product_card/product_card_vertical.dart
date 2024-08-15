import 'package:booktaste/admin/manage_books/add_book/manage_book_controller.dart';
import 'package:booktaste/common/styles/shadows.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/rounded_image.dart';
import 'package:booktaste/common/widgets/popup_menu_button/my_popup_menu_button.dart';
import 'package:booktaste/common/widgets/texts/product_title.dart';
import 'package:booktaste/controllers/book/book_controller.dart';
import 'package:booktaste/data/services/role.manager.dart';
import 'package:booktaste/models/book.dart';

import 'package:booktaste/user/user_all_books/all_books_model.dart';
import 'package:booktaste/user/user_own_lists/read_history_list/read_history_list_controller.dart';
import 'package:booktaste/user/user_own_lists/read_later_list/read_later_list_controller.dart';
import 'package:booktaste/user/user_product_details/product_details_page.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../user/user_own_lists/favourite_list/favourite_list_controller.dart';
import '../../../../utils/popups/dialogs.dart';
import '../../bottom_sheet/my_bottom_sheet.dart';
import '../../icons/circular_icon.dart';
import '../../icons/locked_icon.dart';
import '../../texts/product_price.dart';
import '../../texts/title_with_icon.dart';

class ProductCardVertical extends StatelessWidget {
  ProductCardVertical({
    Key? key,
    this.bookk,
    this.allbooks,
  }) : super(key: key);

  final AllBooks? allbooks;
  final Book? bookk;
  @override
  Widget build(BuildContext context) {
    final favCtrl = Get.put(FavouriteController());

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
                bookCtrl.fetchBookDetails(allbooks == null
                    ? bookk!.id.toString()
                    : allbooks!.id
                        .toString()); //This is what fixed the problem that the first time to click on the card(on first restart) no book details shows up
                final book = bookCtrl.book;

                Get.to(() => ProductDetailsPage(
                      book: book,
                      bookId: allbooks == null
                          ? bookk!.id.toString()
                          : allbooks!.id.toString(),
                    ));
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
                            imageUrl: allbooks == null
                                ? bookk!.cover
                                : allbooks!.cover,
                            isNetworkImage: true,
                            shHeight: 130,
                            shWidth: 100,
                          ),

                          //! -- Locked tag
                          Positioned(
                              top: 5,
                              left: -33,
                              child: allbooks == null
                                  ? bookk!.locked == '1'
                                      ? LockedIcon()
                                      : SizedBox()
                                  : allbooks!.id == '1'
                                      ? LockedIcon()
                                      : SizedBox()),

                          //! Favourite Icon Button
                          Positioned(
                            //*to control the position
                            top: 0,
                            right: -30,
                            child: user == true
                                ? FutureBuilder<bool>(
                                    future: favCtrl.checkIfIsFav(
                                      allbooks == null
                                          ? bookk!.id.toString()
                                          : allbooks!.id.toString(),
                                    ),
                                    builder: (builder, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        final isFav = snapshot.data;
                                        return CircularIcon(
                                          backgroundColor: beige2
                                              .withOpacity(dark ? 0.2 : 0.7),
                                          icon: isFav == true
                                              ? Iconsax.heart
                                              : Iconsax.heart_copy,
                                          color: pinkish,
                                        );
                                      }
                                    })
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
                            title:
                                allbooks == null ? bookk!.name : allbooks!.name,
                            smallSize: true,
                            fontWeightDelta: 2,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: Sizes.spaceBtwItems / 2,
                          ),
                          //! Author
                          TextTitleWithIcon(
                            title: allbooks == null
                                ? bookk!.writer
                                : allbooks!.writer,
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
                              title:
                                  '${allbooks == null ? bookk!.rate : allbooks!.stars} Rating',
                              color: pinkish,
                            )),
                        //! Add to
                        user == true
                            ? AddToListsBtn(
                                allbooks: allbooks,
                                bookk: bookk,
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
                                          //  Get.to(()=>AddNewBookPage(book: ,));
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
                                              ctrl.removeBook(allbooks == null
                                                  ? bookk!.id.toString()
                                                  : allbooks!.id.toString());
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

class AddToListsBtn extends StatelessWidget {
  const AddToListsBtn({
    super.key,
    required this.allbooks,
    required this.bookk,
  });

  final AllBooks? allbooks;
  final Book? bookk;

  @override
  Widget build(BuildContext context) {
    final readLaterCtrl = Get.put(ReadLaterListController());
    final historyCtrl = Get.put(HistoryListController());

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => MyBottomSheet(
            title: 'Add this book to :',
            child: Column(
              children: [
                RoundedContainer(
                  width: 200,
                  child: TextButton(
                    onPressed: () {
                      MyDialogs.defaultDialog(
                          title: 'Set priority of reading',
                          context: context,
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                Obx(
                                  () => ListTile(
                                    title: Text('Low'),
                                    leading: Radio<String>(
                                      value: 'low',
                                      groupValue: readLaterCtrl.priority.value,
                                      onChanged: (String? value) {
                                        readLaterCtrl.setPriority(value!);
                                      },
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => ListTile(
                                    title: Text('High'),
                                    leading: Radio<String>(
                                      value: 'high',
                                      groupValue: readLaterCtrl.priority.value,
                                      onChanged: (String? value) {
                                        readLaterCtrl.setPriority(value!);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          confirmText: 'Add',
                          onConfirm: () {
                            readLaterCtrl.addToLater(
                              allbooks == null
                                  ? bookk!.id.toString()
                                  : allbooks!.id.toString(),
                              readLaterCtrl.priority.value,
                            );
                            Get.back();
                          });
                    },
                    child: Text(
                      'Read Later',
                      style: TextStyle(color: brown),
                    ),
                  ),
                ),
                const SizedBox(
                  height: Sizes.md,
                ),
                RoundedContainer(
                  width: 200,
                  child: TextButton(
                    onPressed: () {
                      TextEditingController startedAtController =
                          TextEditingController(
                              text:
                                  "${DateTime.now().toLocal()}".split(' ')[0]);
                      TextEditingController finishedAtController =
                          TextEditingController(
                              text:
                                  "${DateTime.now().toLocal()}".split(' ')[0]);
                      TextEditingController totalReadTimeController =
                          TextEditingController(text: '03:00:00');
                      DateTime? startDate;
                      DateTime? finishDate;

                      MyDialogs.defaultDialog(
                        context: context,
                        title: 'Add to History',
                        content: SingleChildScrollView(
                          child: SizedBox(
                            height: 220,
                            child: Column(
                              children: [
                                TextField(
                                  readOnly: true,
                                  onTap: () async {
                                    startDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (startDate != null) {
                                      startedAtController.text =
                                          "${startDate!.toLocal()}"
                                              .split(' ')[0];
                                    }
                                  },
                                  controller: startedAtController,
                                  decoration: InputDecoration(
                                    labelText: 'Started At (yyyy/mm/dd)',
                                  ),
                                ),
                                const SizedBox(
                                  height: Sizes.spaceBtwInputFields,
                                ),
                                TextField(
                                  readOnly: true,
                                  onTap: () async {
                                    finishDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                    );
                                    if (finishDate != null) {
                                      finishedAtController.text =
                                          "${finishDate!.toLocal()}"
                                              .split(' ')[0];
                                    }
                                  },
                                  controller: finishedAtController,
                                  decoration: InputDecoration(
                                    labelText: 'Finished At (yyyy/mm/dd)',
                                  ),
                                ),
                                const SizedBox(
                                  height: Sizes.spaceBtwInputFields,
                                ),
                                TextField(
                                  keyboardType: TextInputType.datetime,
                                  controller: totalReadTimeController,
                                  decoration: InputDecoration(
                                    labelText: 'Total Read Time (hh:mm:ss)',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        confirmText: 'Add',
                        onConfirm: () {
                          historyCtrl.addToHistory(
                            allbooks == null
                                ? bookk!.id.toString()
                                : allbooks!.id.toString(),
                            startedAtController.text,
                            totalReadTimeController.text,
                            finishedAtController.text,
                          );
                          Get.back();
                        },
                      );
                    },
                    child: Text(
                      'History',
                      style: TextStyle(color: brown),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: lightBrown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Sizes.cardRadiusMd),
            bottomRight: Radius.circular(Sizes.productImageRadius),
          ),
        ),
        child: SizedBox(
          width: Sizes.iconLg * 1.2,
          height: Sizes.iconLg * 1.2,
          child: Center(
            child: Icon(Icons.add, color: MyColors.white),
          ),
        ),
      ),
    );
  }
}
