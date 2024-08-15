import 'package:booktaste/controllers/category/all_categories_controller.dart';
import 'package:booktaste/models/all_categories_model.dart';
import 'package:booktaste/user/user_all_books/all_books_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constans/colors.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/Containers/rounded_container.dart';
import 'x_card.dart';

class XShowcase extends StatelessWidget {
   XShowcase({
    super.key,
    required this.images, required this.cat,
  });
  final List<String> images;
  final AllCategories cat;
  // final allcacontroller = Get.put(AllCategoriesController())
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);

    return RoundedContainer(
      backgroundColor: dark ? MyColors.black : MyColors.light,
      showBorder: true,
      borderColor: gray,
      padding: EdgeInsets.all(Sizes.md),
      margin: EdgeInsets.only(bottom: Sizes.spaceBtwItems),
      child: Column(
        children: [
          /// genre with books count
          XCard(
            showBorder: false,
            catid: cat.id.toString(),
          ),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          // genre top 3 books images
          Row(
            children: images
                .map((image) => XTopProductImageWidget(image, context))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget XTopProductImageWidget(String image, context) {
    return Expanded(
      child: RoundedContainer(
        height: 100,
        backgroundColor: HelperFunctions.isDarkMode(context)
            ? MyColors.darkGrey
            : MyColors.light,
        margin: const EdgeInsets.only(right: Sizes.sm),
        padding: const EdgeInsets.all(Sizes.md),
        child: Image(
          fit: BoxFit.contain,
          image: AssetImage(image),
        ),
      ),
    );
  }
}
