import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/custom_shapes/Containers/rounded_container.dart';
import 'package:booktaste/common/widgets/images/circular_image.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/user/user_own_lists/reading_list/reading_list_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadingListPage extends StatelessWidget {
  const ReadingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final readingCtrl = Get.put(ReadingListController());
    return Scaffold(
      appBar: MyAppBar(
        title: Text('Current Reading List'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (readingCtrl.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (!readingCtrl.isLoading.value &&
                    readingCtrl.readingList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(Sizes.md),
                    child: Column(
                      children: [
                        Text(
                          'No items in reading list ..',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Center(child: Image.asset(Images.bookShelf)),
                      ],
                    ),
                  );
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Sizes.md),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              "Books you’re currently exploring.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(fontFamily: 'Courier', color: brown),
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      child: MyGridLayout(
                          mainAxisSpacing: Sizes.md,
                          crossAxisCount: 1,
                          itemCount: readingCtrl.readingList.length,
                          itemBuilder: (_, index) {
                            var readBook = readingCtrl.readingList[index];
                            return RoundedContainer(
                              backgroundColor: gray.withOpacity(0.8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ProductCardVertical(
                                      bookk: readBook.book,
                                    ),
                                  ),
                                  Expanded(
                                    child: RoundedContainer(
                                      margin: EdgeInsets.all(Sizes.xs),
                                      width: 130,
                                      padding: EdgeInsets.all(Sizes.sm),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              CircularImage(
                                                backgroundColor: offWhite,
                                                image: Images.bookmarkPage,
                                                width: 54,
                                                height: 54,
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Read:\n',
                                                      style: TextStyle(
                                                          color: brown),
                                                    ),
                                                    TextSpan(
                                                      text: readBook.currentPage
                                                              .toString() +
                                                          ' pages',
                                                      style: TextStyle(
                                                        color:
                                                            MyColors.darkGrey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: Sizes.sm,
                                          ),
                                          Row(
                                            children: [
                                              CircularImage(
                                                backgroundColor: offWhite,
                                                image: Images.percentage,
                                                width: 54,
                                                height: 54,
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Finished:\n',
                                                      style: TextStyle(
                                                          color: brown),
                                                    ),
                                                    TextSpan(
                                                      text: readBook.percentage
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            MyColors.darkGrey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Text('Finished:\n' +
                                              //     readBook.percentage.toString()),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: Sizes.sm,
                                          ),
                                          Row(
                                            children: [
                                              CircularImage(
                                                backgroundColor: offWhite,
                                                image: Images.hourglass,
                                                width: 54,
                                                height: 54,
                                              ),
                                              Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: 'Spent:\n',
                                                      style: TextStyle(
                                                          color: brown),
                                                    ),
                                                    TextSpan(
                                                      text: readBook
                                                          .readTimeSoFar
                                                          .toString(),
                                                      style: TextStyle(
                                                        color:
                                                            MyColors.darkGrey,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // Text('Spent:\n' +
                                              //     readBook.readTimeSoFar.toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
