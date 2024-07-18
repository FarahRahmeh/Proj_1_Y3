import 'package:booktaste/common/widgets/appbar/appbar.dart';
import 'package:booktaste/common/widgets/icons/circular_icon.dart';
import 'package:booktaste/common/widgets/layouts/grid_layout.dart';
import 'package:booktaste/common/widgets/products/product_card/product_card_vertical.dart';
import 'package:booktaste/user/user_home/user_home_page.dart';
import 'package:booktaste/utils/constans/sizes.dart';
import 'package:booktaste/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../admin/navigation/admin_navigation_menu.dart';
import '../navigation/user_navigation_menu.dart';
import '../user_all_books/all_books_controller.dart';

class FavouritePage extends StatelessWidget {
  const FavouritePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final allbookscontroller = Get.put(AllBooksController());
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        title: Text(
          'Favourite',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          CircularIcon(
            backgroundColor: Colors.transparent,
            icon: Iconsax.add_circle_copy,
            onPressed: () {
              final navigationController = Get.find<UserNavigationController>();
              navigationController.setSelectedIndex(0);
              Loaders.customToast(
                  message: 'Where every book is a new taste to explore! 🍭📚',
                  duration: Duration(milliseconds: 2600));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                return MyGridLayout(
                    itemCount: allbookscontroller.booksList.length,
                    itemBuilder: (_, index) => ProductCardVertical(
                          allbooks: allbookscontroller.booksList[index],
                        ));
              })
            ],
          ),
        ),
      ),
    );
  }
}
