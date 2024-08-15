import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/user/user_own_lists/user_unlocked_list/unlocked_list_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnlockedListPage extends StatelessWidget {
  const UnlockedListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final unlockedCtrl = Get.put(UnlockedListController());
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text(
          'UnLocked Books',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (unlockedCtrl.isLoading.value) {
                  Center(child: CircularProgressIndicator());
                } else if (!unlockedCtrl.isLoading.value &&
                    unlockedCtrl.unlockedList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(Sizes.md),
                    child: Column(
                      children: [
                        Text(
                          'You did not unlocked any book ..',
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
                              'Books that stole your heart.',
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
                      //!....................................................
                      height: 400,
                      child: MyGridLayout(
                          itemCount: unlockedCtrl.unlockedList.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                                bookk: unlockedCtrl.unlockedList[index],
                              )),
                    ),
                    // StackedWithImageContainer(),
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
