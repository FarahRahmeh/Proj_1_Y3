import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/user/user_own_lists/favourite_list/favourite_list_controller.dart';
import 'package:booktaste/utils/constans/colors.dart';
import 'package:booktaste/utils/constans/images.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final favCtrl = Get.put(FavouriteController());
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        showBackArrow: true,
        title: Text(
          'Favourite',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (favCtrl.isLoading.value) {
                  Center(child: CircularProgressIndicator());
                } else if (!favCtrl.isLoading.value &&
                    favCtrl.favList.isEmpty) {
                  return Padding(
                    padding: const EdgeInsets.all(Sizes.md),
                    child: Column(
                      children: [
                        Text(
                          'No items in fav ..',
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
                          itemCount: favCtrl.favList.length,
                          itemBuilder: (_, index) => ProductCardVertical(
                                bookk: favCtrl.favList[index],
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
