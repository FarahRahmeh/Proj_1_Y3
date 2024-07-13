import 'package:booktaste/user/user_home/all_categories_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../user/user_home/user_home_controller.dart';
import '../../../utils/constans/colors.dart';
import '../../../utils/constans/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class VerticalImageWithText extends StatelessWidget {
  // final allcategoriescontroller = Get.put(AllCategoriesController());

  const VerticalImageWithText(
      {super.key,
      required this.image,
      // required this.title,
      this.textColor = brown,
      this.backgroundColor,
      this.onTap,
      required this.categories});
  final AllCategories categories;
  final String image;

  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
            right: Sizes
                .spaceBtwItems), //todo add spaceBtwItems / 2 to reduce the space between the genres
        child: Column(
          children: [
            //~ Circular Icon
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(Sizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor,
                //todo    if we want to show the circualr shape of the container uncomment this
                //backgroundColor ?? (dark ? MyColors.black : MyColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  //todo   if the image of the icon is icon(not colored) uncomment the following line
                  //  color: dark? MyColors.white: MyColors.black,   //~ change the colors if you want
                ),
              ),
            ),

            const SizedBox(
              height: Sizes.spaceBtwItems / 2,
            ),
            //~ Text
            SizedBox(
              // width: 55,
              child: Text(
                categories.genre,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                    color: textColor,
                    fontWeightDelta: 2,
                    fontSizeDelta: 0.4), //~------------color
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
