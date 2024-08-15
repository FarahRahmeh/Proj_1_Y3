import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/user/user_own_lists/approved_book_requests/approved_list_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApprovedListPage extends StatelessWidget {
  const ApprovedListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final approvedListCtrl = Get.put(ApprovedListController());
    return Scaffold(
      appBar: MyAppBar(
        title: Text(
          'My Approved list',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (approvedListCtrl.isLoading.value) {
                  Center(child: CircularProgressIndicator());
                } else if (!approvedListCtrl.isLoading.value &&
                    approvedListCtrl.approvedList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(Sizes.md),
                    child: Column(
                      children: [
                        Text(
                          'you have no approved books  ..',
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
                              'Books you recommended and BookTaste approved.',
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
                          itemCount: approvedListCtrl.approvedList.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                                bookk: approvedListCtrl.approvedList[index],
                              )),
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
