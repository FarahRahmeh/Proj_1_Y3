import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/user/user_own_lists/read_history_list/read_history_list_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadHistoryPage extends StatelessWidget {
  const ReadHistoryPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final historyCtrl = Get.put(HistoryListController());
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'Reading History',
        ),
        showBackArrow: true,
        // actions: [
        //   CircularIcon(
        //     backgroundColor: Colors.transparent,
        //     icon: Iconsax.add_circle_copy,
        //     onPressed: () {
        //       final navigationController = Get.find<UserNavigationController>();
        //       navigationController.setSelectedIndex(0);
        //       Loaders.customToast(
        //           message: 'Where every book is a new taste to explore! 🍭📚',
        //           duration: Duration(milliseconds: 2600));
        //     },
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (historyCtrl.isLoading.value) {
                  Center(child: CircularProgressIndicator());
                } else if (!historyCtrl.isLoading.value &&
                    historyCtrl.historyList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(Sizes.md),
                    child: Column(
                      children: [
                        Text(
                          'No items in history ..',
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
                              'Books you’ve finished reading.',
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
                        itemCount: historyCtrl.historyList.length,
                        itemBuilder: (_, index) => ProductCardVertical(
                          bookk: historyCtrl.historyList[index],
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
