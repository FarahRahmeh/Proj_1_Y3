import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/user/user_own_lists/read_later_list/read_later_list_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadLaterPage extends StatelessWidget {
  const ReadLaterPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final readingCtrl = Get.put(ReadLaterListController());
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Read Later List',
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
              right: Sizes.defaultSpace,
              left: Sizes.defaultSpace,
              bottom: Sizes.defaultSpace),
          child: Column(
            children: [
              // Dropdown for selecting order
              Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                      value: readingCtrl.currentOrder.value,
                      items: [
                        DropdownMenuItem(
                          value: 'asc',
                          child: Text('Ascending'),
                        ),
                        DropdownMenuItem(
                          value: 'desc',
                          child: Text('Descending'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          readingCtrl.fetchReadingList(value);
                          readingCtrl.currentOrder.value = value;
                        }
                      },
                    ),
                  ],
                );
              }),
              Obx(() {
                if (readingCtrl.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (!readingCtrl.isLoading.value &&
                    readingCtrl.readLaterList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(Sizes.md),
                    child: Column(
                      children: [
                        Text(
                          'No items in read Later List ..',
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
                              'Books that caught your fancy for later.',
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
                        itemCount: readingCtrl.readLaterList.length,
                        itemBuilder: (_, index) => ProductCardVertical(
                          bookk: readingCtrl.readLaterList[index].book,
                        ),
                      ),
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
